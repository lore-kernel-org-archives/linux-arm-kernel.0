From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 11 May 2014 20:18:02 +0200
Subject: [PATCHv5 14/20] ARM: configs: enable XHCI mvebu support in
 mvebu_v7_defconfig
In-Reply-To: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399832288-19899-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

The Marvell Armada 38x platform needs the xhci_mvebu driver enabled
for the xHCI USB hosts, so this commit enables the corresponding
Kconfig option in mvebu_v7_defconfig.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index a34713d..e881106 100644
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
1.9.2
