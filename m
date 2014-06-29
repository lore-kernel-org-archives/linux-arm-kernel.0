From: carlo@caione.org (Carlo Caione)
Date: Sun, 29 Jun 2014 20:23:56 +0200
Subject: [PATCH v7 5/6] ARM: sunxi: Add AXP20x support in defconfig
In-Reply-To: <1404066237-20234-1-git-send-email-carlo@caione.org>
References: <1404066237-20234-1-git-send-email-carlo@caione.org>
Message-ID: <1404066237-20234-6-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/configs/sunxi_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 7209bfd..acf465f 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -54,6 +54,8 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_AXP20X_PEK=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=8
@@ -77,6 +79,7 @@ CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MFD_AXP20X=y
 CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_AXP20X=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
-- 
1.9.1
