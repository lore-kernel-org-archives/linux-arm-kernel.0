From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 20 Jun 2014 13:02:24 +0100
Subject: [PATCH 1/9] ARM: multi_v7_defconfig: Enable ST's I2C driver
In-Reply-To: <1403265753-25851-1-git-send-email-lee.jones@linaro.org>
References: <1403265753-25851-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1403265753-25851-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 91af0a9..57335e1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -200,6 +200,7 @@ CONFIG_I2C_EXYNOS5=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_SIRF=y
 CONFIG_I2C_TEGRA=y
+CONFIG_I2C_ST=y
 CONFIG_SPI=y
 CONFIG_SPI_OMAP24XX=y
 CONFIG_SPI_ORION=y
-- 
1.8.3.2
