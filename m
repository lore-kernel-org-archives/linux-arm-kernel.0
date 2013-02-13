From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 16:49:02 +0900
Subject: [PATCH] ARM: mach-shmobile: mackerel: enable MMCIF and SDHI in
 defconfig
Message-ID: <1360741742-11342-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm unsure why this isn't already the case.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/mackerel_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
index 7594b3a..ec8e605 100644
--- a/arch/arm/configs/mackerel_defconfig
+++ b/arch/arm/configs/mackerel_defconfig
@@ -94,6 +94,9 @@ CONFIG_USB_RENESAS_USBHS=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHI=y
+CONFIG_MMC_SH_MMCIF=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_EXT2_FS=y
-- 
1.7.10.4
