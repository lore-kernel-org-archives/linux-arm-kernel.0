From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 14 Mar 2014 10:18:22 +0000
Subject: [PATCH v2 4/4] KConfig: Vexpress: build the ARM_GLOBAL_TIMER with
 vexpress platform
In-Reply-To: <1394792302-24451-1-git-send-email-matthew.leach@arm.com>
References: <1394792302-24451-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1394792302-24451-5-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex A5 now contains bindings for the global timer
driver. Ensure that the driver is built with a vexpress platform.

Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 arch/arm/mach-vexpress/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 4a70be4..4fb2a65 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -4,6 +4,7 @@ config ARCH_VEXPRESS
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
+	select ARM_GLOBAL_TIMER
 	select ARM_TIMER_SP804
 	select COMMON_CLK
 	select COMMON_CLK_VERSATILE
-- 
1.8.5.3
