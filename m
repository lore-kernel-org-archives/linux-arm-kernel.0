From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  2 Jun 2014 14:23:42 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Enable ST's I2C driver
Message-ID: <1401715422-18133-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d4e8a47..acb596c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -179,6 +179,7 @@ CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_SIRF=y
 CONFIG_I2C_TEGRA=y
+CONFIG_I2C_ST=y
 CONFIG_SPI=y
 CONFIG_SPI_OMAP24XX=y
 CONFIG_SPI_ORION=y
-- 
1.8.3.2
