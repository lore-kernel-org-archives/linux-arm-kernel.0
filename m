From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Thu, 25 Feb 2016 09:04:09 +0530
Subject: [PATCH] arm64: defconfig: Enable exynos thermal config
Message-ID: <1456371249-10244-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables exynos thermal and related configs for the
TMU found on exynos7 SoC. This also enables thermal emulation
mode to test trip points.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/configs/defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 86581f7..99ac99d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -151,6 +151,9 @@ CONFIG_GPIO_XGENE=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_THERMAL_EMULATION=y
+CONFIG_EXYNOS_THERMAL=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
-- 
1.7.10.4
