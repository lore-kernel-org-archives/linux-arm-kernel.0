From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 26 Jun 2014 14:15:44 +0200
Subject: [PATCH RESEND 2/2] ARM: exynos_defconfig: Enable clock and RTC driver
 for S2M and S5M
In-Reply-To: <1403784944-12890-1-git-send-email-k.kozlowski@samsung.com>
References: <1403784944-12890-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1403784944-12890-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config enables already Samsung's PMIC-s MFD and regulator (S2MPS11
and S5M8767) drivers. Enable also drivers for the rest of these PMIC-s
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
