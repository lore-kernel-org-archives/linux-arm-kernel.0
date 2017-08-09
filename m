From: code@mmayer.net (Markus Mayer)
Date: Wed,  9 Aug 2017 14:56:31 -0700
Subject: [PATCH v3 3/4] ARM: multi_v7_defconfig: add CONFIG_BRCMSTB_THERMAL
In-Reply-To: <20170809215632.4124-1-code@mmayer.net>
References: <20170809215632.4124-1-code@mmayer.net>
Message-ID: <20170809215632.4124-4-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

Turn on CONFIG_BRCMSTB_THERMAL as module.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4d19c1b..230f7fa 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -455,6 +455,7 @@ CONFIG_SENSORS_NTC_THERMISTOR=m
 CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_CPU_THERMAL=y
+CONFIG_BRCMSTB_THERMAL=m
 CONFIG_ROCKCHIP_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
-- 
2.7.4
