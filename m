From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 2 Jan 2014 10:11:17 -0500
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.14 (incr. #2)
Message-ID: <20140102151117.GH19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

This is a nice set of cleanups which lay the groundwork for adding a new
SoC to mach-mvebu.  We'd like to get this in for v3.14 if possible.
It's fairly trivial, mvebu-specific, and Linus did say he was going to
-rc8 this time around.  These patches have also been in -next a minimum
of 5 days.  I held them there a little longer knowing it was the
holidays.

Also, this is an incremental pull, from tags/mvebu-soc-3.14 to
tags/mvebu-soc-3.14-2 on the mvebu/soc branch.  I believe you put the
first round of changes in next/cleanup.  It should be fine to do the
same with these.

thx,

Jason.


The following changes since commit b12634e343bea9ce94ed3252fccbac347f8bb37f:

  ARM: mvebu: fix some sparse warnings (2013-11-24 03:27:54 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.14-2

for you to fetch changes up to 11dc35e4a24c7e650c40077b7843dcda1e9775c3:

  ARM: mvebu: move Armada 370/XP specific definitions to armada-370-xp.h (2013-12-27 18:08:19 +0000)

----------------------------------------------------------------
mvebu SoC changes for v3.14 (incremental #2)

 - mvebu
    - some Armada cleanup to prep for a new SoC in mach-mvebu/

----------------------------------------------------------------
Thomas Petazzoni (3):
      ARM: mvebu: move ARMADA_XP_MAX_CPUS to armada-370-xp.h
      ARM: mvebu: remove prototypes of non-existing functions from common.h
      ARM: mvebu: move Armada 370/XP specific definitions to armada-370-xp.h

 arch/arm/mach-mvebu/armada-370-xp.h | 4 ++++
 arch/arm/mach-mvebu/common.h        | 9 +--------
 2 files changed, 5 insertions(+), 8 deletions(-)
