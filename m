From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:31:36 +0200
Subject: [PATCH 56/71] KConfig: Vexpress: build the ARM_GLOBAL_TIMER with
 vexpress platform
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-56-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthew Leach <matthew.leach@arm.com>

The Cortex A5 now contains bindings for the global timer
driver. Ensure that the driver is built with a vexpress platform.

Signed-off-by: Matthew Leach <matthew.leach@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-vexpress/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 657d52d..e9811a0 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -4,6 +4,7 @@ config ARCH_VEXPRESS
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
+	select ARM_GLOBAL_TIMER
 	select ARM_TIMER_SP804
 	select COMMON_CLK_VERSATILE
 	select HAVE_ARM_SCU if SMP
-- 
1.7.9.5
