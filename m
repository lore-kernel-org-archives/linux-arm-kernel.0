From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 27 Apr 2016 02:55:17 +0300
Subject: [PATCH 1/3] MAINTAINERS: move ARM/NXP LPC32xx record to ARM section
In-Reply-To: <1461714919-25577-1-git-send-email-vz@mleia.com>
References: <1461714919-25577-1-git-send-email-vz@mleia.com>
Message-ID: <1461714919-25577-2-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A record of NXP LPC32xx SoC support is lost between LMxx hwmon drivers
and lockdep, rename and move it to a place where all other ARM
SoC and machines settle.

Note, NXP LPC32xx maintenance is actually about SoC series itself, SoC
peripherals and a number of machines powered by LPC32xx SoC, so while
we are here correct the title name to emphasize that the maintenance
concerns SoC support in general.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03e00c7..233c9bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1306,6 +1306,12 @@ F:	drivers/mtd/spi-nor/nxp-spifi.c
 F:	drivers/rtc/rtc-lpc24xx.c
 N:	lpc18xx
 
+ARM/LPC32XX SOC SUPPORT
+M:	Roland Stigge <stigge@antcom.de>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-lpc32xx/
+
 ARM/MAGICIAN MACHINE SUPPORT
 M:	Philipp Zabel <philipp.zabel@gmail.com>
 S:	Maintained
@@ -6775,12 +6781,6 @@ W:	logfs.org
 S:	Maintained
 F:	fs/logfs/
 
-LPC32XX MACHINE SUPPORT
-M:	Roland Stigge <stigge@antcom.de>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-lpc32xx/
-
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Chaitra P B <chaitra.basappa@broadcom.com>
-- 
2.8.0.rc3
