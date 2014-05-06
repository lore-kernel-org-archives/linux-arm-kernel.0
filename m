From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  6 May 2014 02:14:06 +0200
Subject: [PATCH v3 11/20] ARM: configs: Add usb_xhci_mvebu to
 mvebu_v7_defconfig
In-Reply-To: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1399335255-589-12-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 38x platform needs the xhci_mvebu driver enabled
for the xHCI USB hosts, so this commit enables the corresponding
Kconfig option in mvebu_v7_defconfig.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index a34713d8db9f..e8811066b8e4 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -78,6 +78,7 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_MVEBU=y
 CONFIG_MMC=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_NEW_LEDS=y
-- 
1.8.1.2
