From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 27 Jun 2010 18:47:45 -0600 (MDT)
Subject: [GIT PULL] OMAP: hwmod bug fix for 2.6.35-rc
Message-ID: <alpine.DEB.2.00.1006231828120.1550@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Tony,

this branch contains a single patch which fixes a bug in the hwmod code in 
2.6.35-rc.


- Paul


The following changes since commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02:

  Linux 2.6.35-rc3 (2010-06-11 19:14:04 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 for_2.6.35rc

Benoit Cousson (1):
      OMAP: hwmod: Fix the missing braces

 arch/arm/mach-omap2/omap_hwmod.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)
