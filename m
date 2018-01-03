From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed,  3 Jan 2018 16:54:52 +0100
Subject: [PATCH] arm64: defconfig: enable MESON EFUSE
Message-ID: <20180103155452.2883-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable nvmem meson efuse driver as a module

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6356c6da34ea..1acd8fb440de 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -558,6 +558,7 @@ CONFIG_PHY_XGENE=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
+CONFIG_MESON_EFUSE=m
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_ARM_SCPI_PROTOCOL=y
-- 
2.14.3
