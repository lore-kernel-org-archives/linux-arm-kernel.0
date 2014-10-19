From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sun, 19 Oct 2014 13:53:01 +0200
Subject: [PATCH 2/3] ARM: socfpga: enable PL330_DMA
In-Reply-To: <1413719582-16014-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1413719582-16014-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1413719582-16014-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the PL330 DMA controller in the SoCFPGA.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/configs/socfpga_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index cc26bc96a4c8..40eaca055c85 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -79,6 +79,8 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_DWC2_HOST=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
+CONFIG_DMADEVICES=y
+CONFIG_PL330_DMA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
2.1.1
