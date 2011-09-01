From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Sep 2011 22:11:07 +0100
Subject: [GIT PULL] CPU mapping platform updates for 3.2
Message-ID: <20110901211107.GB5209@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following CPU mapping patches for 3.2. Russell has merged
the core changes into his for-next branch, so this pull is based against
that (following the merging discussion we had previously). I can rebase
onto next/master if you prefer.

Cheers,

Will


The following changes since commit 3ad29450aa243a318fae5d50bdc918760436bb02:

  Merge branch 'devel-stable' into for-next (2011-08-28 10:41:19 +0100)

are available in the git repository at:

  git://linux-arm.org/linux-2.6-wd.git for-arnd

Will Deacon (5):
      ARM: exynos4: convert logical CPU numbers to physical numbers
      ARM: msm: convert logical CPU numbers to physical numbers
      ARM: shmobile: convert logical CPU numbers to physical numbers
      ARM: ux500: convert logical CPU numbers to physical numbers
      ARM: versatile: convert logical CPU numbers to physical numbers

 arch/arm/mach-exynos4/hotplug.c     |    2 +-
 arch/arm/mach-exynos4/platsmp.c     |    2 +-
 arch/arm/mach-msm/hotplug.c         |    2 +-
 arch/arm/mach-msm/platsmp.c         |    2 +-
 arch/arm/mach-realview/hotplug.c    |    2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c |    6 +++++-
 arch/arm/mach-ux500/hotplug.c       |    2 +-
 arch/arm/mach-ux500/platsmp.c       |    2 +-
 arch/arm/mach-vexpress/hotplug.c    |    2 +-
 arch/arm/plat-versatile/platsmp.c   |    2 +-
 10 files changed, 14 insertions(+), 10 deletions(-)
