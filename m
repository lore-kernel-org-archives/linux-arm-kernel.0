From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 16 Nov 2011 17:02:05 +0100
Subject: [GIT PULL] ARM: OMAP: hwmod fix for 3.2-rc3
Message-ID: <4EC3DE7D.9050609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

That bug is becoming annoying, and a bunch of folks are hitting that issue during DT dev for 3.3, so it will be cool to fix that ASAP.

It might already be in Paul's queue for 3.2-rc3.

Thanks,
Benoit


The following changes since commit 6aaf05f472c97ebceff47d9eef464574f1a55727:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git390.marist.edu/pub/scm/linux-2.6

are available in the git repository at:

  git://gitorious.org/omap-pm/linux.git for_3.2-rc/hwmod-fixes

sricharan (1):
      ARM: OMAP: hwmod: Fix the addr space, irq, dma count APIs

 arch/arm/mach-omap2/omap_hwmod.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
