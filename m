From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Mon, 14 May 2018 16:58:59 +0200
Subject: [PATCH] arm64: defconfig: enable the Armada thermal driver
Message-ID: <20180514145859.22812-1-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the Armada thermal driver to support thermal
management on Marvell EBU Armada SoCs (7K,8K).

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf613761e78..8f0707bcc54d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -343,6 +343,7 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
+CONFIG_ARMADA_THERMAL=y
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
-- 
2.17.0
