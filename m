From: njun@marvell.com (Jun Nie)
Date: Wed, 21 Sep 2011 21:07:21 +0800
Subject: [V3 0/4] ARM: mmp: Add mmc support on pxa910 DKB board
Message-ID: <1316610446-24183-1-git-send-email-njun@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add mmc support on PXA910 DKB board.
It is similiar with V2 in Apr, just align with modified sdhci-pxav2
version driver.

Jun Nie (4):
  ARM: mmp: add pxa910 mmc resource
  ARM: mmp: append mmc 2v8 regulator on dkb board
  ARM: mmp: support sd card on pxa910 dkb board
  ARM: mmp: support emmc on dkb board

 arch/arm/mach-mmp/include/mach/mfp-pxa910.h |   15 ++++
 arch/arm/mach-mmp/include/mach/pxa910.h     |   15 ++++
 arch/arm/mach-mmp/include/mach/regs-apmu.h  |    1 +
 arch/arm/mach-mmp/pxa910.c                  |    9 +++
 arch/arm/mach-mmp/ttc_dkb.c                 |  100 +++++++++++++++++++++++++++
 5 files changed, 140 insertions(+), 0 deletions(-)
