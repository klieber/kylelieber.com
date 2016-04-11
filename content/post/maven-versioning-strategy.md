+++
title = "Maven Versioning Strategy"
date = "2012-06-25"
slug = "maven-versioning-strategy"
categories = ["Development"]
tags = ["maven", "best practice", "versioning", "release"]
+++
I've been having a lot of discussions with analysts in my organization about how to version software using Maven and I'm finding there is a common misconception about what SNAPSHOT actually means. I've been looking for a good blog to send them that helps explain versioning in Maven but unfortunately everything I've found merely discusses version formats and not how to use them as you're developing an application. So, I decided I would take a stab at it. I welcome any comments and constructive criticism that will help me improve this document, so please feel free.
<!--more-->
First off, a SNAPSHOT is not the same thing as an alpha/beta/etc version. It is a special keyword that means it is the latest version of your code. This means it changes. If you pulled down someapp-1.0-SNAPSHOT yesterday and then you try to pull it down today it will most likely not be the same. This also means if you have a project dependent on a SNAPSHOT version, maven will need to check the remote repository for changes every time you run a build.

Next thing to understand is what a release is in Maven. A release does NOT mean that the version is ready for production. It means that the developer has decided he is at a point in his development that he wants to have the code locked down so it is not lost. He may also want to distribute that code to someone, maybe its a library a developer on another team needs to get started on their own applications development or maybe it's an application that will be installed on a test environment for testing. So this means a maven release can be an alpha, beta, release candidate, patch, production, or whatever else you want to categorize it as.

Make sense? Well, maybe walking through a scenario of how i handle this would help you. First lets look at the versioning strategy I use:

## Versioning Strategy

The syntax for this strategy is based off of the format in [Maven: The Complete Reference][1]. The differences are I'm renaming "incremental version" to "patch" and breaking up the optional "qualifier" into "type" and an "attempt" simply for clarity.

`<major>.<minor>.<patch>[-<type>-<attempt>]`

*   `<major>` - This is a number indicating a significant change in the application. A major version might possibly be a complete rewrite of the previous major version and/or break backwards compatibility with older versions.
*   `<minor>` - This is a number that indicates a small set of changes from the previous minor version. A minor version usually consists of an even set of bug fixes and new features and should always be backwards compatible.
*   `<patch>` - This is a number that indicates some bugs were fixed that couldn't wait until the next minor release. A patch version should only include bug fixes and never include new features. It should also always be backwards compatible. Security fixes are an example of a typical patch.
*   `[<type>-<attempt>]` - This is last part is optional and only used to identify that this version is not necessarily stable. The type is a keyword and can be anything but I usually stick to alpha, beta, and RC. The attempt is just a number to indicate which attempt at this type is this. So for example, beta-01, RC-02, RC-05, ect. For a stable version, I leave off this part, however, I've seen other projects that like to use the keyword of RELEASE to indicate the stable version (you leave off the attempt because that wouldn't make sense, use RC (release candidate) for that).

## Example Scenerio

So now for the scenario. Let's say I'm working on the foobar application. My organization is expecting me to deliver foobar version `1.0` at the end of the quarter. (Notice I say `1.0` which means I'm only using the first two numbers to refer to the version. That is because major and minor version are really the only versions anyone will care about other than your development team. Also, there's no way for me to know what the final version will be but I do know the major and minor will stay the same.) I'm working on an agile team so I am going to be deploying whatever I have done at the end of each sprint to my test environment so my testers can validate everything. So, here's what I might do:

I will start with version `1.0.0-SNAPSHOT` in my pom.xml at the beginning of the Sprint #1. At the end of Sprint #1, I will use the maven-release-plugin to create the `foobar-1.0.0-RC-01` release of the foobar application. The plugin will change the version from `1.0.0-SNAPSHOT` to `1.0.0-RC-01`, tag the code in scm with `foobar-1.0.0-RC-01`, and then finally build that release. Then plugin will then update the trunk to be the next development version of the application which we will leave at `1.0.0-SNAPSHOT`. Then I will deploy `foobar-1.0.0-RC-01` to the test environment. This process will continue for the next couple sprints until we get to a phase where we are to a point where we think we are complete.

So let's say we are now at Sprint #5. We've released four release candidate versions of the application, fixing bugs and adding features along the way. Now we feel `foobar-1.0.0-RC-04` is ready for production use. Now I run the maven-release-plugin again to create the `foobar-1.0.0` version of my application. Again, the plugin will tag the current version of the code in scm with `foobar-1.0.0` and then build that release. The plugin will then update the trunk to be the next development version of the application which this time I choose to be `1.1.0-SNAPSHOT`.

Notice, I increment the minor version and not the patch version. In a perfect world, I would be done with the `1.0` version but of course this isn't a perfect world and most likely I'll have to patch my `1.0.0` version at some point. Since I don't know when that will be I'm going to just move on with life and start working on the next version of the application, `1.1`.

A few weeks later my QA team informs me that a bug was found in release testing that needs to be fixed. What am I going to do now? I've moved on and have new `1.1` code in the trunk that can't go into release `1.0`. No worries, I remember that the release plugin tags each of my releases for me. So, I create a branch from the `foobar-1.0.0` tag and call it `foobar-1.0.X`. Then I checkout that new branch and increment the patch version to `1.0.1-SNAPSHOT`. This new branch is now my patching branch. I will fix the bug reported to me by the QA team and use the release plugin to produce patch version `foobar-1.0.1`. Then immediately after producing `foobar-1.0.1` I will merge the `1.0.1` changes into the trunk so that the fix is present in version `1.1` (which has yet to be released).

Then I take a deep breath and go back to working on `1.1`. If another bug comes up, maybe even after we go out to production, I will just continue going back to my `foobar-1.0.X` patching branch to make the fix and merge the changes back in to the trunk.

## Simplified Strategy

I don't always use the above strategy. In fact, a lot of the time I use what I would call a simplified version of this strategy. Essentially, it's the same thing except I remove the `-<type>-<attempt>` completely and instead of a `<patch>`, I have a more generic `<incrementalVersion>` (just like in the maven book). So it looks like this:

`<major>.<minor>.<incrementalVersion>`

Let's go back to the example scenario above and compare the full strategy with this simplified strategy:

    | Iteration    | Full Strategy  | Simplified Strategy |
    |--------------|----------------|---------------------|
    | Sprint #1    | 1.0.0-RC-01    | 1.0.0               |
    | Sprint #2    | 1.0.0-RC-02    | 1.0.1               |
    | Sprint #3    | 1.0.0-RC-03    | 1.0.2               |
    | Sprint #4    | 1.0.0-RC-04    | 1.0.3               |
    | Production   | 1.0.0          | 1.0.3               |
    | First Patch  | 1.0.1          | 1.0.4               |
    | Next Version | 1.1.0          | 1.1.0               |

As you can see the simplified strategy loses some of the verbosity of the full strategy which can be a good and a bad thing. It's not going to be obvious whether a version is ready for production or just a release candidate. However, it does mean you don't have to test the accepted release candidate twice. If you noticed the version delivered by Sprint #4 is also the production version. There's no need to rebuild it just to remove the `-RC-04`.

For a smaller team or a team that doesn't really have their artifacts consumed by many other areas this may be a better solution because there is a lot less versioning to manage. You just need to make sure you are communicating clearly with your team so everyone knows what is going on.

 [1]: http://www.sonatype.com/books/mvnref-book/reference/pom-relationships-sect-pom-syntax.html
