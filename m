From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 25 Oct 2018 20:36:59 +0530
Subject: [PATCH v2] arm64: defconfig: Enable MFD_AXP20X_I2C
Message-ID: <20181025150659.19657-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner H6 SoC is paired with the X-Powers AXP805 PMIC
connected via I2C.

Enable the driver for this PMIC.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com> # OPI-1+
---
Changes for v2:
- collect Maxime ack
- add tested-by credit

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b1071d42b4ca..4aebbcf70f9f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -389,6 +389,7 @@ CONFIG_MESON_WATCHDOG=m
 CONFIG_RENESAS_WDT=y
 CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
+CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_BD9571MWV=y
 CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=y
-- 
2.18.0.321.gffc6fa0e3
