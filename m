From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Fri, 06 Nov 2015 10:05:33 +0530
Subject: [PATCH] arm64: defconfig: Enable samsung MFD and related configs
Message-ID: <1446784533-31911-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables below configs by default:
 * CONFIG_MFD_SEC_CORE
 * CONFIG_REGULATOR_S2MPS11
 * CONFIG_RTC_DRV_S5M

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/configs/defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9492fe7edbbc..78e89e690dc1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -131,9 +131,11 @@ CONFIG_GPIO_XGENE=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
+CONFIG_MFD_SEC_CORE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
+CONFIG_REGULATOR_S2MPS11=y
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -162,6 +164,7 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_S5M=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
-- 
1.7.10.4
