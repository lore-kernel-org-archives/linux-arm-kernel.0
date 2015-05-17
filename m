From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 17 May 2015 17:09:48 +0900
Subject: [PATCH 3/4] ARM: multi_v7_defconfig: Enable TMU for Exynos
In-Reply-To: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431850195-9558-7-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for Thermal Monitoring Unit present on Exynos SoCs. This
allows detection of overheat and handling this gracefully.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6a6a292c5bf8..6ee2c24dfbc7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -343,6 +343,7 @@ CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
+CONFIG_EXYNOS_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_DAVINCI_WATCHDOG
-- 
2.1.4
