+++
categories = ["Development"]
date = "2018-09-21T23:59:43-05:00"
draft = true
slug = "restdocs-spec"
tags = ["java", "rest", "spring", "spring-restdocs", "openapi", "maven"]
title = "Generate OpenAPI Specs with Spring REST Docs"

+++
Many of the teams at my organization began using Spring REST Docs to document our REST APIs over the last couple of years.  We really like the freedom it gives you to design your documentation as you wish while still giving you reliable snippets that are validated through tests.  Of course, the only thing its missing is the ability to generate an API specification document like OpenAPI.  This recently became a requirement that we are able to provide such a document so many thought we would need to abandon Spring REST Docs.

Fortunately, we have been having regular "hack days" to take some time away from our day-to-day work and attack problems we would otherwise never get to work on.  Last month, a couple of us decided to tackle the challenge of coming up with a way to generate OpenAPI specs using Spring REST Docs.

Our approach was simple.  Basically, we decided the easiest thing to do would be to follow the same model Spring REST Docs already uses for generating HTML sites.  It's a two step process:

1. Generate snippet files during the run of your tests.  Usually asciidoc files.
2. After the test run, use a maven plugin to join all those snippet files into an HTML site.  Usually the asciidoctor-maven-plugin.

So, we would follow that same process only instead of generate asciidoc files for our snippets we would generate a json file that contained all the information about the resource.  The instead of using the asciidoctor-maven-plugin to join everything together we would create our own plugin that would read in all the json files and spit out an OpenAPI spec.

At the end of the hack we had a working snippet and plugin that produced a valid OpenAPI spec.  However, we still had a lot of work to do because we were not getting any of the field or parameter documentation in our json snippets so the OpenAPI file that was generated was pretty bare.

Of course, as I've learned time and time again over my career as a software engineer, you can rarely have a unique idea.  Only a few days after our hack a comment showed up on the [Spring REST Docs issue](https://github.com/spring-projects/spring-restdocs/issues/213) that has been open for over two years requesting OpenAPI support. Someone had built a solution to the problem and their solution followed the same basic idea as ours.  The only real difference was that they built a gradle plugin rather than a maven plugin.  The other difference is that they had been working on it for quite a few months now so their snippet was much more advanced than what we had wrote at that point.

So, after getting over my frustration that my cool unique idea was not at all unique I decided that this was really a great thing.  This developer had a snippet that could generate everything we needed and we had a maven plugin which they did not have.  So, we decided best thing to do was to work together to help improve their project and contribute a maven plugin that was compatible with it.

The end result is the [restdocs-spec-maven-plugin](https://github.com/BerkleyTechnologyServices/restdocs-spec).  This plugin works in conjuction with the [restdocs-openapi](https://github.com/ePages-de/restdocs-openapi) which is maintained by [Mathias Düsterhöft](https://github.com/mduesterhoeft) and his organization.  I won't get into the specifics of how to use them both here in this blog post because both projects have that information in their respective README files.  

I also want to thank Mathias for being so friendly and open to my contributions.  That is what the open source community is all about!