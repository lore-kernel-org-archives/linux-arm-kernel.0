From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 23 May 2018 15:35:31 +0200
Subject: [PATCH] arm64: defconfig: Enable BD9571MWV regulator
Message-ID: <1527082531-11640-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dien Pham <dien.pham.ry@renesas.com>

The BD9571 PMIC is present on the Renesas Salvator-X(S) and R-Car
Starter Kit Premier/Pro development boards.

Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3a9096bebc74b288..8e430fce8dc97dee 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -363,6 +363,7 @@ CONFIG_MESON_WATCHDOG=m
 CONFIG_RENESAS_WDT=y
 CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
+CONFIG_MFD_BD9571MWV=y
 CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=y
@@ -375,6 +376,7 @@ CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_REGULATOR_AXP20X=y
+CONFIG_REGULATOR_BD9571MWV=y
 CONFIG_REGULATOR_FAN53555=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
-- 
2.7.4
