From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 14 Mar 2014 21:13:13 -0400
Subject: [ARM ATTEND] devicetree repo, early testing
Message-ID: <20140315011313.GE15608@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I would like to attend this years ARM mini-summit to be held in
conjunction with the Embedded Linux Conference on April 28th.  There are
two topics I would like to discuss.

- devicetree repo -

I recently sent out an email regarding moving the devicetree binding
docs and dts{i} files to their own repo.

  https://lkml.kernel.org/r/20140217180544.GU7862 at titan.lakedaemon.net

This started a rather long thread that distilled down to two main
topics:  Short term syncing of the devicetree for other projects, and
long-term, how do we migrate to separate repository?

The short term appears to be solved with Ian Campbell's work on
extracting the history from the Linux Kernel history.  He has a
continuously updated tree available that is easy for other projects to
merge in as a submodule or any other way they see fit.

The fun part is the long term transition.  Ideally, Olof would like to
see this happen on a per-sub-arch basis as they are ready.  Ian
indicated there may be difficulties in implementing this.  This is what
I would like to hammer out.

  1) what migration approach would actually work?

  2) what are the criteria for "this sub-arch is ready"?

  3) does Ian need to move the repo to a more neutral location?  iow, do
     the interested parties (busybox, u-boot, *bsd) care about it being
     hosted on a Linux-y site?

So, I'd like the opportunity to take what we've collected from the
mailinglist so far, hammer it out; and after the summit, be able to post
a proposal/plan.

- early testing of new patches -

I'd like to take the opportunity to sit down with other ARM folks and
share what mvebu has been doing since the 2013 KS wrt topic branches,
merging, and the early testing this process has enabled.  I'd also like
to cover some lessons learned and also some tips and tricks.

Our process has allowed us to smoothly merge in support for three new
SoCs (Armada 375/380/385), with drivers, in one merge cycle.  We've also
migrated DT support from two legacy SoCs (dove, kirkwood) into
mach-mvebu this cycle as well.

This would also be a great opportunity for others to chime in with their
experiences, tips and tricks.

thx,

Jason.
