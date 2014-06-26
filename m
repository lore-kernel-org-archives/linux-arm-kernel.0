From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 26 Jun 2014 14:15:43 +0200
Subject: [PATCH RESEND 1/2] ARM: multi_v7_defconfig: Enable clock and RTC
 driver for S2M and S5M
Message-ID: <1403784944-12890-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config enables already Samsung's PMIC-s MFD and regulator (S2MPS11
and S5M8767) drivers. Enable also drivers for the rest of these PMIC-s
features: clock and RTC.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index be1a3455a9fe..d578ebbc05a0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -334,6 +334,7 @@ CONFIG_RTC_DRV_VT8500=y
 CONFIG_RTC_DRV_SUNXI=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_RTC_DRV_TEGRA=y
+CONFIG_RTC_DRV_S5M=y
 CONFIG_DMADEVICES=y
 CONFIG_DW_DMAC=y
 CONFIG_MV_XOR=y
@@ -355,6 +356,7 @@ CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
 CONFIG_QCOM_GSBI=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
-- 
1.9.1
