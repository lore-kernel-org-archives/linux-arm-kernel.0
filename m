From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue, 17 May 2016 14:35:53 +0000
Subject: [PATCH V3 5/5] ARM: multi_v7_defconfig: bcm2835: add bcm2835-thermal
 driver
In-Reply-To: <1463495753-967-1-git-send-email-kernel@martin.sperl.org>
References: <1463495753-967-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463495753-967-6-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the thermal driver to list of compiled modules in
multi_v7_defconfig.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Changelog:
 V1 -> V2: added this patch
 V2 -> V3: made driver compile as a module not in-kernel
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1e799fe..bd6d400 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -422,6 +422,7 @@ CONFIG_CPU_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
+CONFIG_BCM2835_THERMAL=m
 CONFIG_DAVINCI_WATCHDOG=m
 CONFIG_EXYNOS_THERMAL=m
 CONFIG_ST_THERMAL_SYSCFG=y
--
2.1.4
