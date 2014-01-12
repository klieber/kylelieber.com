---
layout: post
title: "Avoid absolute file path when using the cxf-codegen-plugin"
date: 2012-03-30 21:30:58.000000000 -05:00
comments: true
categories:
- Development
tags:
- maven
- apache cxf
- web services
- java
- wsdl
---
I ran into this problem a few months ago and scoured the internet for solution but never found one until now. So hopefully this will be helpful to someone with the same problem. By default, the [Apache CXF Codegen Maven plugin][1] generates code that will attempt to read your wsdl via the absolute path.

So for instance:

``` xml
    <plugin>
      <groupId>org.apache.cxf</groupId>
      <artifactId>cxf-codegen-plugin</artifactId>
      <version>${cxf.version}</version>
      <executions>
        <execution>
          <id>generate-sources</id>
          <phase>generate-sources</phase>
          <configuration>
            <sourceRoot>${project.build.directory}/generated-sources/cxf</sourceRoot>
            <wsdlOptions>
              <wsdlOption>
                <wsdl>${project.basedir}/src/main/resources/wsdl/FooService.wsdl</wsdl>
              </wsdlOption>
            </wsdlOptions>
          </configuration>
          <goals>
            <goal>wsdl2java</goal>
          </goals>
        </execution>
      </executions>
    </plugin>
```   

Will produce the following:

``` java
    @WebServiceClient(name = "Foo_Service",
                      wsdlLocation = "file:/home/user/sandbox/example/src/main/resources/wsdl/FooService.wsdl",
                      targetNamespace = "http://www.examples.com/wsdl/FooService.wsdl")
    public class FooService extends Service {
    
      public final static URL WSDL_LOCATION;
    
      public final static QName SERVICE = new QName("http://www.examples.com/wsdl/FooService.wsdl", "Foo_Service");
      public final static QName FooPort = new QName("http://www.examples.com/wsdl/FooService.wsdl", "Foo_Port");
      static {
        URL url = null;
        try {
          url = new URL("file:/home/user/sandbox/example/src/main/resources/wsdl/FooService.wsdl");
        } catch (MalformedURLException e) {
           java.util.logging.Logger.getLogger(FooService.class.getName())
               .log(java.util.logging.Level.INFO,
                    "Can not initialize the default wsdl from {0}", "file:/home/user/sandbox/example/src/main/resources/wsdl/FooService.wsdl");
        }
        WSDL_LOCATION = url;
      }
``` 

As you can see its trying to read the wsdl from an absolute path, which really doesn't make this code very portable. So the first thought you might have is just use the `<wsdlLocation />` tag to set the location to a relative path like this:

``` xml
    <plugin>
      <groupId>org.apache.cxf</groupId>
      <artifactId>cxf-codegen-plugin</artifactId>
      <version>${cxf.version}</version>
      <executions>
        <execution>
          <id>generate-sources</id>
          <phase>generate-sources</phase>
          <configuration>
            <sourceRoot>${project.build.directory}/generated-sources/cxf</sourceRoot>
            <wsdlOptions>
              <wsdlOption>
                <wsdl>${project.basedir}/src/main/resources/wsdl/FooService.wsdl</wsdl>
                <wsdlLocation>wsdl/FooService.wsdl</wsdlLocation>
              </wsdlOption>
            </wsdlOptions>
          </configuration>
          <goals>
            <goal>wsdl2java</goal>
          </goals>
        </execution>
      </executions>
    </plugin>
``` 

However, if you're using a version of cxf-codegen-plugin prior to 2.4.6, you'll find that it won't work because it generates invalid code that will result in a `MalformedURLException` since you can't instantiate a URL with a relative path:

``` java
    @WebServiceClient(name = "Foo_Service",
                      wsdlLocation = "wsdl/FooService.wsdl",
                      targetNamespace = "http://www.examples.com/wsdl/FooService.wsdl")
    public class FooService extends Service {
    
      public final static URL WSDL_LOCATION;
    
      public final static QName SERVICE = new QName("http://www.examples.com/wsdl/FooService.wsdl", "Foo_Service");
      public final static QName FooPort = new QName("http://www.examples.com/wsdl/FooService.wsdl", "Foo_Port");
      static {
        URL url = null;
        try {
          url = new URL("wsdl/FooService.wsdl");
        } catch (MalformedURLException e) {
          java.util.logging.Logger.getLogger(FooService.class.getName())
              .log(java.util.logging.Level.INFO,
                   "Can not initialize the default wsdl from {0}", "wsdl/FooService.wsdl");
        }
        WSDL_LOCATION = url;
      }
```

I recently found that starting with 2.4.6 though it will actually generate somewhat more reasonable code:

``` java
    @WebServiceClient(name = "Foo_Service",
                      wsdlLocation = "wsdl/FooService.wsdl",
                      targetNamespace = "http://www.examples.com/wsdl/FooService.wsdl")
    public class FooService extends Service {
    
      public final static URL WSDL_LOCATION;
    
      public final static QName SERVICE = new QName("http://www.examples.com/wsdl/FooService.wsdl", "Foo_Service");
      public final static QName FooPort = new QName("http://www.examples.com/wsdl/FooService.wsdl", "Foo_Port");
      static {
        URL url = FooService.class.getResource("wsdl/FooService.wsdl");
        if (url == null) {
          java.util.logging.Logger.getLogger(FooService.class.getName())
              .log(java.util.logging.Level.INFO,
                   "Can not initialize the default wsdl from {0}", "wsdl/FooService.wsdl");
        }
        WSDL_LOCATION = url;
      }
```

Note the use of `FooService.class.getResource("wsdl/FooService.wsdl")`. This is actually a big improvement over the way the previous version of the plugin worked, however it still doesn't work in my situation because the getResource method on a class looks for a resource relative to the package the class belongs too. So I would need to have my wsdl in `src/main/resources/com/examples/wsdl/fooservice_wsdl/wsdl/FooService.wsdl`. It might not be a terrible way to organize my wsdls by package but that's not what I'm looking for. What I really want is a way so that the code uses `FooService.class.getClassLoader().getResource("wsdl/FooService.wsdl")` and until now my solution was to use an ant build with a ReplaceRegExp task to change the code CXF generates to look this way. However, there is a much simpler and better way built in to the plugin starting with version 2.4.1 that is apparently not documented very well:

``` xml
    <plugin>
      <groupId>org.apache.cxf</groupId>
      <artifactId>cxf-codegen-plugin</artifactId>
      <version>${cxf.version}</version>
      <executions>
        <execution>
          <id>generate-sources</id>
          <phase>generate-sources</phase>
          <configuration>
            <sourceRoot>${project.build.directory}/generated-sources/cxf</sourceRoot>
            <wsdlOptions>
              <wsdlOption>
                <wsdl>${project.basedir}/src/main/resources/wsdl/FooService.wsdl</wsdl>
                <wsdlLocation>classpath:wsdl/FooService.wsdl</wsdlLocation>
              </wsdlOption>
            </wsdlOptions>
          </configuration>
          <goals>
            <goal>wsdl2java</goal>
          </goals>
        </execution>
      </executions>
    </plugin>
``` 

Yep, that's it. Just prefix the value of the wsdlLocation with "classpath:" and it will generate code the reads the resource from the classpath using the classloader:

``` java
    @WebServiceClient(name = "Foo_Service",
                      wsdlLocation = "classpath:wsdl/FooService.wsdl",
                      targetNamespace = "http://www.examples.com/wsdl/FooService.wsdl")
    public class FooService extends Service {
    
      public final static URL WSDL_LOCATION;
    
      public final static QName SERVICE = new QName("http://www.examples.com/wsdl/FooService.wsdl", "Foo_Service");
      public final static QName FooPort = new QName("http://www.examples.com/wsdl/FooService.wsdl", "Foo_Port");
      static {
        URL url = FooService.class.getClassLoader().getResource("wsdl/FooService.wsdl");
        if (url == null) {
          java.util.logging.Logger.getLogger(FooService.class.getName())
              .log(java.util.logging.Level.INFO,
                   "Can not initialize the default wsdl from {0}", "classpath:wsdl/FooService.wsdl");
        }
        WSDL_LOCATION = url;
      }
```

 [1]: http://cxf.apache.org/docs/maven-cxf-codegen-plugin-wsdl-to-java.html
