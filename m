From: shawn.gsc@gmail.com (Shawn Guo)
Date: Fri, 22 Oct 2010 00:23:43 +0800
Subject: [PATCH 0/2] mx25_3ds & mx35_3ds: add mmc support
Message-ID: <1287678225-11066-1-git-send-email-shawn.gsc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch was tested on top of Uwe's build fix below. 

 ARM: mx3: fix build failure concerning MXC_INT_MMC_SDHC2

Shawn Guo (3)
 [PATCH 1/2] mx35_3ds: add mmc support
 [PATCH 2/2] mx25_3ds: add mmc support

 arch/arm/mach-mx25/Kconfig         |    1 +
 arch/arm/mach-mx25/mach-mx25_3ds.c |   10 ++++++++++
 arch/arm/mach-mx3/Kconfig          |    1 +
 arch/arm/mach-mx3/mach-mx35_3ds.c  |    8 ++++++++
 4 files changed, 20 insertions(+), 0 deletions(-)
