From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Dec 2012 14:04:41 -0800
Subject: [GIT PULL 0/3] ARM: arm-soc: Third and final batch foe 3.8
Message-ID: <20121214220441.GA11363@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here is the last batch of branches for 3.8. It's wrapping up merges for
SPEAr and socfpga, some additional contents for Exynos and shmobile and
a large update for mvebu/kirkwood.

For kirkwood, we're working on figuring out the workflow better with the
submaintainers, they have a rapid pace of development and end up with a
lot of interdependent topic branches. So we grouped them in a topic on
their own this merge window; something we're trying to avoid overall.

Same procedure as last time, merge conflicts documented in each request
and *-resolved branches pushed for reference.

And thanks for your tolerance of merge conflicts in this merge window,
it's been a relatively bad one and we'll work to avoid more of the silly
ones for 3.9.

>From here on out it'll mostly be fixes, and possibly a few straggling
patches.


Thanks,

-Olof
