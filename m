From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 16:41:17 +0200
Subject: [PATCH v2 2/3] ARM: configs: add CONFIG_MMC_SDHCI_PXAV3 to the
 mvebu_v7_defconfig
In-Reply-To: <1397486478-16991-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397486478-16991-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397486478-16991-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 38x platform has a SDHCI interface managed by the
sdhci-pxav3 MMC host driver. It therefore makes sense to enable this
driver in mvebu_v7_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index a34713d..26be7ff 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -79,6 +79,7 @@ CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_MMC=y
+CONFIG_MMC_SDHCI_PXAV3=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_GPIO=y
-- 
1.8.3.2
