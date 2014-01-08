---
layout: post
status: publish
published: true
title: Avoid absolute file path when using the cxf-codegen-plugin
author: klieber
author_login: klieber
author_email: me@kylelieber.com
author_url: http://kylelieber.com
wordpress_id: 30
wordpress_url: http://kylelieber.com/?p=30
date: 2012-03-30 21:30:58.000000000 -05:00
categories:
- Development
tags:
- maven
- apache cxf
- web services
- java
- wsdl
comments:
- id: 3
  author: Marc
  author_email: marc.karou@gmail.com
  author_url: ''
  date: !binary |-
    MjAxMi0wNC0yNyAwMjo0OToxMCAtMDUwMA==
  date_gmt: !binary |-
    MjAxMi0wNC0yNyAwNzo0OToxMCAtMDUwMA==
  content: ! 'Very usefull post, I was looking for an elegant solution to do it !
    I was forced to duplicate my wsdl file to make my ws work. The key was the cxf-codegen-plugin
    version, thanks :)

'
- id: 609
  author: James
  author_email: james.a.hutton@gmail.com
  author_url: ''
  date: !binary |-
    MjAxMy0wOS0xOSAwOToyODo1MSAtMDUwMA==
  date_gmt: !binary |-
    MjAxMy0wOS0xOSAxNDoyODo1MSAtMDUwMA==
  content: ! 'Any thoughts on how one would apply this generically when using a glob
    for a bunch of wsdls?  I''d appreciate not having to declare each wsdl.

'
- id: 794
  author: Â¥Â±Â¥Â¤Â¥ÃˆÂ¥Â¹Â¥ÃšÂ©`Â¥Ã‰ Â¥Â¢Â¥Â¦Â¥ÃˆÂ¥Ã¬Â¥ÃƒÂ¥Ãˆ
  author_email: czpfzkc@gmail.com
  author_url: http://Â¥Â±Â¥Â¤Â¥ÃˆÂ¥Â¹Â¥ÃšÂ©Â¥Ã‰Â¥Â¢Â¥Â¦Â¥ÃˆÂ¥Ã¬Â¥ÃƒÂ¥Ãˆ
  date: !binary |-
    MjAxMy0xMi0xNyAxMjowOTowNCAtMDYwMA==
  date_gmt: !binary |-
    MjAxMy0xMi0xNyAxODowOTowNCAtMDYwMA==
  content: ! 'A reliable seller values their reputation but will gladly respond to
    all of your questions in detail for the reason that have nothing to hide.

    Â¥Â±Â¥Â¤Â¥ÃˆÂ¥Â¹Â¥ÃšÂ©`Â¥Ã‰ Â¥Â¢Â¥Â¦Â¥ÃˆÂ¥Ã¬Â¥ÃƒÂ¥Ãˆ http://www.amoregen.com/

'
- id: 805
  author: canada goose constable parka
  author_email: ! '**********@gmail.com'
  author_url: http://canadagooseconstableparka
  date: !binary |-
    MjAxMy0xMi0yMiAxMDo0MzoyNyAtMDYwMA==
  date_gmt: !binary |-
    MjAxMy0xMi0yMiAxNjo0MzoyNyAtMDYwMA==
  content: ! 'good

    http://www.darinkamontano.com/

    http://www.awfmmellowtouch.net/

    http://www.rajasthantour-travels.com/

    [url=http://www.awfmmellowtouch.net/]canada goose constable parka[/url]

'
- id: 849
  author: Sandra
  author_email: bxebddrc@gmail.com
  author_url: http://Sandra
  date: !binary |-
    MjAxMy0xMi0zMSAwMjo1NjoxNCAtMDYwMA==
  date_gmt: !binary |-
    MjAxMy0xMi0zMSAwODo1NjoxNCAtMDYwMA==
  content: ! 'This is a comment to the admin. Your website is missing out on at least
    300 visitors per day. I have found a company which offers to dramatically increase
    your visitors to your website: http://2hams.com/2312h They offer 1,000 free visitors
    during their free trial period and I managed to get over 30,000 visitors per month
    using their services, you could also get lot more targeted traffic than you have
    now. Hope this helps :) Take care.

    Sandra http://2hams.com/2312t

'
- id: 876
  author: Nancy
  author_email: grrqxf@gmail.com
  author_url: http://Nancy
  date: !binary |-
    MjAxNC0wMS0wNSAyMDoyOTo1NyAtMDYwMA==
  date_gmt: !binary |-
    MjAxNC0wMS0wNiAwMjoyOTo1NyAtMDYwMA==
  content: ! 'I came to your page and noticed you could have a lot more hits. I have
    found that the key to running a popular website is making sure the visitors you
    are getting are interested in your subject matter. There is a company that you
    can get traffic from and they let you try their service for free. I managed to
    get over 300 targeted visitors to day to my site. Check it out here: http://2hams.com/51a

    Nancy http://2hams.com/51a

'
- id: 881
  author: ! "ã‚¢ã‚° ãƒ–ãƒ¼ãƒ„ æ­£è¦\x8Få“\x81"
  author_email: nhjvwqmdxc@gmail.com
  author_url: ! "http://ã‚¢ã‚°ãƒ–ãƒ¼ãƒ„æ­£è¦\x8Få“\x81"
  date: !binary |-
    MjAxNC0wMS0wNiAxNDo1OTowMiAtMDYwMA==
  date_gmt: !binary |-
    MjAxNC0wMS0wNiAyMDo1OTowMiAtMDYwMA==
  content: ! "Hi there, just became alert to your blog through Google, and found that
    it is truly informative. I am gonna watch out for brussels. I'll appreciate if
    you continue this in future. A lot of people will be benefited from your writing.
    Cheers!|\nã‚¢ã‚° ãƒ–ãƒ¼ãƒ„ æ­£è¦\x8Få“\x81 http://www.mwhittlephoto.com/\n"
---
<p>I ran into this problem a few months ago and scoured the internet for solution but never found one until now. So hopefully this will be helpful to someone with the same problem. By default, the <a href="http://cxf.apache.org/docs/maven-cxf-codegen-plugin-wsdl-to-java.html">Apache CXF Codegen Maven plugin</a> generates code that will attempt to read your wsdl via the absolute path.</p>

<p>So for instance:</p>

<pre><code>&lt;plugin&gt;
  &lt;groupId&gt;org.apache.cxf&lt;/groupId&gt;
  &lt;artifactId&gt;cxf-codegen-plugin&lt;/artifactId&gt;
  &lt;version&gt;${cxf.version}&lt;/version&gt;
  &lt;executions&gt;
    &lt;execution&gt;
      &lt;id&gt;generate-sources&lt;/id&gt;
      &lt;phase&gt;generate-sources&lt;/phase&gt;
      &lt;configuration&gt; 
        &lt;sourceRoot&gt;${project.build.directory}/generated-sources/cxf&lt;/sourceRoot&gt;
        &lt;wsdlOptions&gt;
          &lt;wsdlOption&gt;
            &lt;wsdl&gt;${project.basedir}/src/main/resources/wsdl/FooService.wsdl&lt;/wsdl&gt;
          &lt;/wsdlOption&gt;
        &lt;/wsdlOptions&gt;
      &lt;/configuration&gt;
      &lt;goals&gt;
        &lt;goal&gt;wsdl2java&lt;/goal&gt;
      &lt;/goals&gt;
    &lt;/execution&gt;
  &lt;/executions&gt;
&lt;/plugin&gt;
</code></pre>

<p>Will produce the following:</p>

<pre><code>@WebServiceClient(name = "Foo_Service",
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
</code></pre>

<p>As you can see its trying to read the wsdl from an absolute path, which really doesn't make this code very portable. So the first thought you might have is just use the <code>&lt;wsdlLocation /&gt;</code> tag to set the location to a relative path like this:</p>

<pre><code>&lt;plugin&gt;
  &lt;groupId&gt;org.apache.cxf&lt;/groupId&gt;
  &lt;artifactId&gt;cxf-codegen-plugin&lt;/artifactId&gt;
  &lt;version&gt;${cxf.version}&lt;/version&gt;
  &lt;executions&gt;
    &lt;execution&gt;
      &lt;id&gt;generate-sources&lt;/id&gt;
      &lt;phase&gt;generate-sources&lt;/phase&gt;
      &lt;configuration&gt; 
        &lt;sourceRoot&gt;${project.build.directory}/generated-sources/cxf&lt;/sourceRoot&gt;
        &lt;wsdlOptions&gt;
          &lt;wsdlOption&gt;
            &lt;wsdl&gt;${project.basedir}/src/main/resources/wsdl/FooService.wsdl&lt;/wsdl&gt;
            &lt;wsdlLocation&gt;wsdl/FooService.wsdl&lt;/wsdlLocation&gt;
          &lt;/wsdlOption&gt;
        &lt;/wsdlOptions&gt;
      &lt;/configuration&gt;
      &lt;goals&gt;
        &lt;goal&gt;wsdl2java&lt;/goal&gt;
      &lt;/goals&gt;
    &lt;/execution&gt;
  &lt;/executions&gt;
&lt;/plugin&gt;
</code></pre>

<p>However, if you're using a version of cxf-codegen-plugin prior to 2.4.6, you'll find that it won't work because it generates invalid code that will result in a <code>MalformedURLException</code> since you can't instantiate a URL with a relative path:</p>

<pre><code>@WebServiceClient(name = "Foo_Service",
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
</code></pre>

<p>I recently found that starting with 2.4.6 though it will actually generate somewhat more reasonable code:</p>

<pre><code>@WebServiceClient(name = "Foo_Service",
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
</code></pre>

<p>Note the use of <code>FooService.class.getResource("wsdl/FooService.wsdl")</code>. This is actually a big improvement over the way the previous version of the plugin worked, however it still doesn't work in my situation because the getResource method on a class looks for a resource relative to the package the class belongs too. So I would need to have my wsdl in <code>src/main/resources/com/examples/wsdl/fooservice_wsdl/wsdl/FooService.wsdl</code>. It might not be a terrible way to organize my wsdls by package but that's not what I'm looking for. What I really want is a a way so that the code uses <code>FooService.class.getClassLoader().getResource("wsdl/FooService.wsdl")</code> and until now my solution was to use an ant build with a ReplaceRegExp task to change the code CXF generates to look this way. However, there is a much simpler and better way built in to the plugin starting with version 2.4.1 that is apparently not documented very well:</p>

<pre><code>&lt;plugin&gt;
  &lt;groupId&gt;org.apache.cxf&lt;/groupId&gt;
  &lt;artifactId&gt;cxf-codegen-plugin&lt;/artifactId&gt;
  &lt;version&gt;${cxf.version}&lt;/version&gt;
  &lt;executions&gt;
    &lt;execution&gt;
      &lt;id&gt;generate-sources&lt;/id&gt;
      &lt;phase&gt;generate-sources&lt;/phase&gt;
      &lt;configuration&gt; 
        &lt;sourceRoot&gt;${project.build.directory}/generated-sources/cxf&lt;/sourceRoot&gt;
        &lt;wsdlOptions&gt;
          &lt;wsdlOption&gt;
            &lt;wsdl&gt;${project.basedir}/src/main/resources/wsdl/FooService.wsdl&lt;/wsdl&gt;
            &lt;wsdlLocation&gt;classpath:wsdl/FooService.wsdl&lt;/wsdlLocation&gt;
          &lt;/wsdlOption&gt;
        &lt;/wsdlOptions&gt;
      &lt;/configuration&gt;
      &lt;goals&gt;
        &lt;goal&gt;wsdl2java&lt;/goal&gt;
      &lt;/goals&gt;
    &lt;/execution&gt;
  &lt;/executions&gt;
&lt;/plugin&gt;
</code></pre>

<p>Yep, that's it. Just prefix the value of the wsdlLocation with "classpath:" and it will generate code the reads the resource from the classpath using the classloader:</p>

<pre><code>@WebServiceClient(name = "Foo_Service",
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
</code></pre>
