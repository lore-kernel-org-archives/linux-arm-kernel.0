From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 31 Jul 2018 19:08:28 +0530
Subject: [PATCH] arm64: defconfig: Enable MFD_AXP20X_I2C
Message-ID: <20180731133828.2582-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner H6 SoC is paired with the X-Powers AXP805 PMIC
connected via I2C.

Enable the driver for this PMIC.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f9a186f6af8a..2fdf01f11af8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -370,6 +370,7 @@ CONFIG_MESON_WATCHDOG=m
 CONFIG_RENESAS_WDT=y
 CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
+CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=y
-- 
2.18.0.321.gffc6fa0e3
