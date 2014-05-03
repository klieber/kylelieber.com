---
layout: post
title: "PhantomJS Maven Plugin 0.3"
date: 2014-05-02 22:50:41 -0500
comments: true
categories: 
---
I just released [version 0.3](https://github.com/klieber/phantomjs-maven-plugin/releases/tag/phantomjs-maven-plugin-0.3) of the [phantomjs-maven-plugin](http://kylelieber.com/phantomjs-maven-plugin) and I thought it was about time I wrote a blog post about this project.

[PhantomJS](http://phantomjs.org) is a headless WebKit implementation that is extremely useful for tasks like headless website testing, screen capture, page automation, network monitoring, and more. Much of my experience with PhantomJS comes from my work on the [jasmine-maven-plugin](http://searls.github.io/jasmine-maven-plugin).  In version `1.3.1.1` of the plugin we added support for using PhantomJS instead of [HtmlUnit](http://htmlunit.sourceforge.com) to execute [Jasmine](http://jasmine.github.io/) specs. The only downside to using PhantomJS with the plugin is that you had to have PhantomJS already installed on your system. For those of us in the Maven world that seems a little odd since Maven is suppose to download all of our dependencies for us. But of course, usually those dependencies are platform-independent java libraries. PhantomJS, on the other hand, requires install platform-dependent compiled binaries. 

Well after a few months of explaining to users and friends that they needed to have the plugin installed and there was no good way to have it installed automatically, I decided I need to fix that. So, I took some inspiration from the work done on the [Arquillian Phantom Driver](https://github.com/qa/arquillian-phantom-driver) and wrote the phantomjs-maven-plugin.

The plugin works by first determining the current OS and architecture type that it is running on and then downloading the appropriate version of the PhantomJS binaries and set a property indicating the location of the executable.  The versions of the plugin prior to `0.3` would download the binaries directly from either googlecode or bitbucket where PhantomJS hosts them.  This latest version now downloads them via maven's central repository (downloading directly is still an option) which is great because it helps avoid firewall issues and allows for easy caching.

The plugin also features a [goal for executing](http://kylelieber.com/phantomjs-maven-plugin/exec-mojo.html) PhantomJS scripts so you can easily install and execute PhantomJS scripts inside your maven build.

You can see an example usage of the plugin with the jasmine-maven-plugin [here](http://kylelieber.com/phantomjs-maven-plugin/).  I'm working on getting more documentation out there so until then you can also look at the [sample projects](https://github.com/klieber/phantomjs-maven-plugin/tree/master/src/it) I use for the plugins integration tests. 

I've been having a hard time keeping up on this and the jasmine-maven-plugin lately (partly because I need a new laptop terribly) but I hope to begin making regular commits again soon. Thank you for your patience.
