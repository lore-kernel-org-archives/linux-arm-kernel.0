From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 3 Jul 2012 13:22:16 -0300
Subject: [PATCH] ARM: imx: Kconfig: Remove IMX_HAVE_PLATFORM_IMX_SSI from
 MACH_MX25_3DS
Message-ID: <1341332536-2967-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 5fb86e5d4 (ARM: mx31_3ds: Add sound support) added audio support for
mx31pdk, but touched MACH_MX25_3DS Kconfig by mistake.

Remove IMX_HAVE_PLATFORM_IMX_SSI from MACH_MX25_3DS configuration.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index eff4db5..0da882a 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -158,7 +158,6 @@ config MACH_MX25_3DS
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
 	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
-- 
1.7.1
