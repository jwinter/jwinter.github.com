---
layout: post
title: Code Review jwinter-style
tags: []
status: publish
type: post
published: true
meta: {}
---

# Code Review @jwinter-style

I really enjoy reviewing code. I think it's mostly because I enjoy listening  and talking to people about programming. So here are some thoughts of my rambling thoughts on reviewing code.

First, I **try to be cognizant of other people's feelings during code review**. It's easy to sound rude by giving curt, negative feedback. Sometimes it takes more time to reword a comment in more sensitive language. I've never regretted taking the time to do that. I have regretted hastily sending off a comment that sounds like a jerk wrote it.

Speaking of which, there have been times where following my feedback would have **absolutely** resulted in a change for the worse. If you review code long enough and have a modicum of self-awareness, this will also happen to you. Be prepared for it and let the author and other reviewers know when you change your mind.

I also try to respect the author of the pull request by doing the following (and sometimes I screw this up):
* Point out what they've done great! Everybody forgets this one! Why don't you do this?!
* Phrase refactoring suggestions as suggestions. Rarely, I "very strongly" suggest a refactoring, but even in that case I try to say so in a way that respects the work that's already gone into this change.
* Ask before I add commits to their pull request. If I don't get a response quickly, I'll generally just put some sample code into my comments to show what I'm suggesting.
* Provide performance specifics. When I think the code is too slow, instead of just saying something like "This looks too slow", I'll try to provide specific numbers or offer help in profiling.
* OFFER HELP! I'll offer to pair on something during or after a review.
* When I do think the code needs reworking, I either provide a specific way to improve the code or have one in mind. I won't always suggest a specific change because that often narrows the author's thinking on how to make an improvement.

So here are the actual steps I go through.

First, I **check out the branch to review in my local git repo**. If you don't check out the branch you're reviewing locally, I'm not really sure how you can provide a close review. There's several important steps below that you just can't do by looking at the code on Github alone.

Next, if the branch won't merge cleanly, I'll rebase it locally (and not push my changes) before starting this process. If there are a lot of merge conflicts, I'll ask for the author to merge master into this branch or rebase it on master, or whatever they prefer to get it closer to our master branch.

**Then, I run our entire test suite (unit, functional, integration, whatever) locally.** Some may be wondering why I just don't just let our continuous integration server run the tests on the branch. I run tests locally, in addition to the CI server, because once this code passes review, it will be the new master branch. And I will be using that immediately in whatever I'm working on. So if my local dev environment is going to start failing tests, I want to know as soon as possible. It's also a great time to ask for help because the person sending the pull request still has the code fresh in their mind and is especially motivated to get the change through.

While the tests are running, I read the diffs on Github. **I like to look at the whole diff across all files.** If it's a particularly large or complicated pull request, I may drill into specific commits. But I don't really care which commit a particular change came from, since I'm not reviewing that commit I'm reviewing the whole branch. 

**Some quick things I look for on my first pass:**
* Any change where there's not a corresponding change in test code
* New methods or variables that go unused
* Anything that doesn't match our (implicit or explict) style guide
* Anything that reminds me of a bug I've hit before. An example here might be using ||= for memoization in Ruby.
* Any goddamn trailing whitespace
* Anything that I want to take a closer look at

Things that fall under that last bullet would be any change in data structure, any new data structures, any change in logic or addition of new logic, etc. Basically anything other than the simplest 1-2 line change where only I could screw it up, I'll want to take a closer look at.

After that first pass, I'll either be just about done if it's a small change or ready to start taking a closer look at the bits I've identified from the first pass. 

This is the point where I usually **read the request that spawned this change** (bug report/feature request/bar napkin) and then **actually use the new feature or attempt to repro the bug**. I don't think most people do this, based on how many garbage features or unfixed bugs I've shipped that my co-workers have happily +1ed. This is a really important step, maybe the most important, so please actually run the code that you're reviewing.

**Now, when taking a closer look, I'll do any combination of the following:**
* Think about how the change will run in production.
* Reverse their logic and make sure the right tests fail.
* Drop into the debugger and walk through the code to see if it runs how I expect.
* Copy their code into a REPL and make sure it does what I think it's supposed to.
* Walk back up call stack to see if any of the arguments expected to be one type are actually of that type, e.g. non-null, array, etc.
* Write (or run an existing) load or stress test.


And **before I finally +1 the change I check that:**
* Every comment I've made has been responded to, either with code or with a discussion.
* All tests pass locally.
* Any new ideas or features that have come out of review are tracked somewhere.
* It merges cleanly. I've seen enough bugs introduced during merge resolution that I'll ask folks to merge master or rebase before completing my review.

So what's above is what I use to help me improve the code I look at. I'm very interested in what helps others do the same. **Get at me at [@jwinter on twitter](https://twitter.com/jwinter) if you've got feedback on this.** I'd love to hear it.
