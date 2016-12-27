From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Dec 2016 13:05:29 +0100
Subject: [PATCH 2/3] ARM: defconfig: tegra: switch to MPU3050 IIO driver
In-Reply-To: <20161227120530.31190-1-linus.walleij@linaro.org>
References: <20161227120530.31190-1-linus.walleij@linaro.org>
Message-ID: <20161227120530.31190-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra is currently configured to use the old input driver for the
MPU-3050. Switch to the new IIO driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/tegra_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 844eeef5a509..f0efc854b5a2 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -120,7 +120,6 @@ CONFIG_TOUCHSCREEN_WM97XX=y
 # CONFIG_TOUCHSCREEN_WM9713 is not set
 CONFIG_TOUCHSCREEN_STMPE=y
 CONFIG_INPUT_MISC=y
-CONFIG_INPUT_MPU3050=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
@@ -263,6 +262,7 @@ CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_ARCH_TEGRA_124_SOC=y
 CONFIG_MEMORY=y
 CONFIG_IIO=y
+CONFIG_MPU3050_I2C=y
 CONFIG_AK8975=y
 CONFIG_PWM=y
 CONFIG_PWM_TEGRA=y
-- 
2.9.3
