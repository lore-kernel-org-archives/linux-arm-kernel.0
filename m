From: plaes@plaes.org (Priit Laes)
Date: Wed, 16 Sep 2015 10:55:42 +0300
Subject: [PATCH] ARM: sunxi_defconfig: Enable LRADC keys (KEYBOARD_SUN4I_LRADC)
Message-ID: <1442390142-1294-1-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 51eea22..94c6bd0 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -63,6 +63,7 @@ CONFIG_STMMAC_ETH=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_AXP20X_PEK=y
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_KEYBOARD_SUN4I_LRADC=y
 CONFIG_TOUCHSCREEN_SUN4I=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-- 
2.5.2
