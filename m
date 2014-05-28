From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 28 May 2014 11:00:13 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable clock and RTC driver for S2M
 and S5M
Message-ID: <1401267613-8232-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config enables already Samsung's PMIC-s MFD driver and regulators
(S2MPS11 and S5M8767). Enable also drivers for rest of these PMIC-s
features: clock and RTC.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 839d16ab7b81..71f2e42978d7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -321,6 +321,7 @@ CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_VT8500=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_RTC_DRV_TEGRA=y
+CONFIG_RTC_DRV_S5M=y
 CONFIG_DMADEVICES=y
 CONFIG_DW_DMAC=y
 CONFIG_MV_XOR=y
@@ -341,6 +342,7 @@ CONFIG_KEYBOARD_NVEC=y
 CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
-- 
1.9.1
