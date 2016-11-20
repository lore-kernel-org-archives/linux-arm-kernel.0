From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 20 Nov 2016 19:10:35 +0530
Subject: [GIT PULL 1/4] DaVinci cleanups for v4.10 (part 2)
Message-ID: <20161120134038.14998-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 766763dbdc1dca11deabdb00077a1c19e2803f0a:

  ARM: davinci: da8xx: Remove duplicated defines (2016-10-31 16:51:56 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git davinci-for-v4.10/cleanup-2

for you to fetch changes up to f7715b299954b1f1644253682e50f38282eee611:

  ARM: davinci: PM: fix build when da850 not compiled in (2016-11-20 16:52:00 +0530)

----------------------------------------------------------------
mach-davinci cleanup to make it easy to add PM support
for DT-boot.

----------------------------------------------------------------
Kevin Hilman (3):
      ARM: davinci: PM: rework init, remove platform device
      ARM: davinci: PM: cleanup: remove references to pdata
      ARM: davinci: PM: fix build when da850 not compiled in

 arch/arm/mach-davinci/Makefile             |   4 +-
 arch/arm/mach-davinci/board-da850-evm.c    |  17 +----
 arch/arm/mach-davinci/board-mityomapl138.c |  16 +----
 arch/arm/mach-davinci/common.c             |   1 -
 arch/arm/mach-davinci/da850.c              |  38 -----------
 arch/arm/mach-davinci/include/mach/da8xx.h |   1 -
 arch/arm/mach-davinci/pm.c                 | 102 ++++++++++++++++-------------
 7 files changed, 62 insertions(+), 117 deletions(-)
