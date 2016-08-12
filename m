From: fabf@skynet.be (Fabian Frederick)
Date: Fri, 12 Aug 2016 23:28:55 +0200
Subject: [PATCH 1/1 linux-next] ARM: imx: remove platform-mxc_rnga
Message-ID: <1471037335-11149-1-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to commit c9ee94965dce
("ARM: imx: deconstruct mxc_rnga initialization")

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 arch/arm/mach-imx/devices/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/devices/Makefile b/arch/arm/mach-imx/devices/Makefile
index e5cf587..aa6cee8 100644
--- a/arch/arm/mach-imx/devices/Makefile
+++ b/arch/arm/mach-imx/devices/Makefile
@@ -20,7 +20,6 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MX2_CAMERA) += platform-mx2-camera.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_EHCI) += platform-mxc-ehci.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_MMC) += platform-mxc-mmc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
-obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RNGA) += platform-mxc_rnga.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RTC) += platform-mxc_rtc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) += platform-sdhci-esdhc-imx.o
-- 
2.8.1
