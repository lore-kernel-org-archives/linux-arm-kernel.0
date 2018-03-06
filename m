From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue,  6 Mar 2018 18:35:02 +0530
Subject: [PATCH 2/3] arm64: defconfig: enable thermal sensor on QCOM platforms
In-Reply-To: <cover.1520340931.git.amit.kucheria@linaro.org>
References: <cover.1520340931.git.amit.kucheria@linaro.org>
Message-ID: <3c0f37be33dba8500fe39a0951f67a6882245afa.1520340931.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the driver for the TSENS IP that is present across several QCOM
SoCs.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373..80530cb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -327,6 +327,7 @@ CONFIG_THERMAL_EMULATION=y
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
+CONFIG_QCOM_TSENS=y
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
@@ -562,6 +563,7 @@ CONFIG_PHY_XGENE=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
+CONFIG_QCOM_QFPROM=y
 CONFIG_UNIPHIER_EFUSE=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-- 
2.7.4
