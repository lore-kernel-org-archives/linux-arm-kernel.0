From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Thu, 30 Nov 2017 10:26:55 +0900
Subject: [PATCH] arm64: defconfig: enable CONFIG_UNIPHIER_EFUSE
Message-ID: <1512005215-6323-1-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the efuse driver for UniPhier SoC

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6356c6d..41e1b56 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -558,6 +558,7 @@ CONFIG_PHY_XGENE=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
+CONFIG_UNIPHIER_EFUSE=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_ARM_SCPI_PROTOCOL=y
-- 
2.7.4
