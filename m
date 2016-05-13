From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 13 May 2016 13:13:06 +0000
Subject: [PATCH-V2 5/5] ARM: multi_v7_defconfig: bcm2835: add bcm2835-thermal
 driver
In-Reply-To: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org>
References: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463145186-12906-6-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the thermal driver to list of compiled modules in
multi_v7_defconfig.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2823490..5f0f5a3 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -422,6 +422,7 @@ CONFIG_CPU_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_BCM2835_THERMAL=y
 CONFIG_DAVINCI_WATCHDOG=m
 CONFIG_EXYNOS_THERMAL=m
 CONFIG_ST_THERMAL_SYSCFG=y
-- 
2.1.4
