From: olof@lixom.net (Olof Johansson)
Date: Mon,  1 Oct 2012 16:56:55 -0700
Subject: [GIT PULL 0/12] ARM: soc: updates for 3.7, first batch
Message-ID: <1349135827-24790-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here is the first batch of pull requests for arm-soc for this merge
window. Some of them are tiny, and we will probably start to combine
them into slightly larger misc branches in the future. I didn't do it
this time around since the dependencies between branches ended up quite
complex this time around.

We unfortunately have a somewhat conflict-heavy merge window in front
of us. The reason is a couple of substantial moves of header files and
Makefile contents on platforms. The shuffling is done to allow multiple
platforms to be built into the same kernel image, a goal that has
been worked towards for quite some time now and finally are bearing
fruit. We're starting out with just a few platforms but it's expected
that several more will be enabled for 3.8.

As usual I have described the conflicts in each pull request and how I
resolved them. I have also pushed up a temporary branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git merge-part1-resolved

that contains the merges as I have done them.

With that, here comes the first batch of updates. There will be a second
batch later on once these have been merged.


Thanks!

-Olof
