From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 28 May 2014 12:16:07 +0200
Subject: [PATCH] ARM: exynos_defconfig: Enable clock and RTC driver for S2M and
 S5M
Message-ID: <1401272167-3125-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config enables already Samsung's PMIC-s MFD driver and regulators
(S2MPS11 and S5M8767). Enable also drivers for rest of these PMIC-s
features: clock and RTC.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index e07a227ec0db..f69b86b650fa 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -109,7 +109,9 @@ CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S3C=y
+CONFIG_RTC_DRV_S5M=y
 CONFIG_COMMON_CLK_MAX77686=y
+CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
-- 
1.9.1
