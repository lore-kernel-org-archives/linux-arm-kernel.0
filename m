From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 12 Dec 2013 12:14:29 -0300
Subject: [PATCH] ARM: configs: Select USB PHY for AM335x SoC
Message-ID: <1386861269-28949-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable this option as it's required to use USB on AM335x SoC.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 12c848e..e427b95 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -223,6 +223,7 @@ CONFIG_USB_TEST=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_OMAP_USB2=y
 CONFIG_OMAP_USB3=y
+CONFIG_AM335X_PHY_USB=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
-- 
1.8.1.5
