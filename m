From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 23 Dec 2014 10:53:13 +0800
Subject: [PATCH v8 5/6] ARM: sunxi: Add AXP20x support in defconfig
In-Reply-To: <1419303194-3075-1-git-send-email-wens@csie.org>
References: <1419303194-3075-1-git-send-email-wens@csie.org>
Message-ID: <1419303194-3075-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@caione.org>

Signed-off-by: Carlo Caione <carlo@caione.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/sunxi_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 7a342d2780a8..0a781e3c6de3 100644
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
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.1.4
