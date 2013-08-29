From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 29 Aug 2013 19:36:43 -0400
Subject: [PATCH v2 3/4] ARM: keystone: Enable clock drivers
In-Reply-To: <1377819404-9671-1-git-send-email-santosh.shilimkar@ti.com>
References: <1377819404-9671-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1377819404-9671-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable common clock drivers on Keystone 2 based SOCs.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 51a50e9..f912776 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -10,6 +10,7 @@ config ARCH_KEYSTONE
 	select HAVE_SCHED_CLOCK
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_ERRATA_798181 if SMP
+	select COMMON_CLK_KEYSTONE
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
 	  SoCs.
-- 
1.7.9.5
