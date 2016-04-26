From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 27 Apr 2016 02:55:19 +0300
Subject: [PATCH 3/3] MAINTAINERS: add ARM/NXP LPC32XX SoC specific drivers to
 the section
In-Reply-To: <1461714919-25577-1-git-send-email-vz@mleia.com>
References: <1461714919-25577-1-git-send-email-vz@mleia.com>
Message-ID: <1461714919-25577-4-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds a list of files for maintenance under NXP LPC32xx
section, the listed files are NXP LPC32xx SoC series mach files,
DTS files of NXP LPC32xx SoC powered boards and NXP LPC32xx SoC
peripheral drivers, most of the peripheral driver file names match
'lpc32xx' pattern.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e70c5a8..117a3c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1312,7 +1312,13 @@ M:	Sylvain Lemieux <slemieux.tyco@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://github.com/vzapolskiy/linux-lpc32xx.git
 S:	Maintained
+F:	arch/arm/boot/dts/lpc32*
 F:	arch/arm/mach-lpc32xx/
+F:	drivers/i2c/busses/i2c-pnx.c
+F:	drivers/net/ethernet/nxp/lpc_eth.c
+F:	drivers/usb/host/ohci-nxp.c
+F:	drivers/watchdog/pnx4008_wdt.c
+N:	lpc32xx
 
 ARM/MAGICIAN MACHINE SUPPORT
 M:	Philipp Zabel <philipp.zabel@gmail.com>
-- 
2.8.0.rc3
