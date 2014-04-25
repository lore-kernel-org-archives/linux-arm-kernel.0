From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Apr 2014 16:07:07 +0200
Subject: [PATCH v2 09/18] ARM: configs: Add usb_xhci_mvebu to
 multi_v7_defconfig
In-Reply-To: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
References: <1398434836-18908-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1398434836-18908-10-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 38x platform needs the xhci_mvebu driver enabled
for the xHCI USB hosts, so this commit enables the corresponding
Kconfig option in multi_v7_defconfig.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d4e8a47a2f7c..820cc35d40cf 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -254,6 +254,7 @@ CONFIG_SND_SOC_TEGRA_ALC5632=y
 CONFIG_SND_SOC_TEGRA_MAX98090=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_MVEBU=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_TEGRA=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
-- 
1.8.1.2
