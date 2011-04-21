From: niej0001@gmail.com (Jun Nie)
Date: Thu, 21 Apr 2011 09:56:35 +0800
Subject: [PATCH v2 0/3] ARM: mmp: support mmc on PXA910 DKB board
Message-ID: <BANLkTi=sXpEYjMooMJiVuCzWXkCVYtP58g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add mmc support on PXA910 DKB board.
Changes vs Version 1:
    1. Define APMU_SDH2_PXA910 for PXA910 has different APMU_SDH2 address.
    2. Polish mmc regulator code

0001-ARM-mmp-add-pxa910-mmc-resource.patch
0002-ARM-mmp-append-mmc-2v8-regulator-on-dkb-board.patch
0003-ARM-mmp-support-mmc-on-pxa910-dkb-board.patch

 arch/arm/mach-mmp/include/mach/mfp-pxa910.h |   15 ++++++
 arch/arm/mach-mmp/include/mach/pxa910.h     |   19 +++++++
 arch/arm/mach-mmp/include/mach/regs-apmu.h  |    1 +
 arch/arm/mach-mmp/pxa910.c                  |    9 ++++
 arch/arm/mach-mmp/ttc_dkb.c                 |   68 +++++++++++++++++++++++++++
 5 files changed, 112 insertions(+), 0 deletions(-)
