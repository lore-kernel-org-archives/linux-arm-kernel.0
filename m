From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 25 Nov 2014 18:17:35 +0000
Subject: [PATCH 2/2] MAINTAINERS: ARM Versatile Express platform
In-Reply-To: <1416939455-1814-1-git-send-email-pawel.moll@arm.com>
References: <1416939455-1814-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1416939455-1814-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a separate section for the ARM
Versatile Express platform maintainers, listing
all different bits and bobs used by it.

Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 MAINTAINERS | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ff630d..e0cb002 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1503,6 +1503,25 @@ S:	Maintained
 F:	drivers/clk/ux500/
 F:	include/linux/platform_data/clk-ux500.h
 
+ARM/VERSATILE EXPRESS PLATFORM
+M:	Liviu Dudau <liviu.dudau@arm.com>
+M:	Sudeep Holla <sudeep.holla@arm.com>
+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/boot/dts/vexpress-*
+F:	arch/arm/mach-vexpress/*
+F:	drivers/bus/vexpress-config.c
+F:	drivers/clk/versatile/clk-vexpress-osc.c
+F:	drivers/clocksource/versatile.c
+F:	drivers/cpufreq/vexpress-spc-cpufreq.c
+F:	drivers/hwmon/vexpress.c
+F:	drivers/mfd/vexpress-sysreg.c
+F:	drivers/misc/vexpress-vexpress-syscfg.c
+F:	drivers/power/reset/vexpress-poweroff.c
+F:	drivers/regulator/vexpress.c
+F:	include/linux/vexpress.h
+
 ARM/VFP SUPPORT
 M:	Russell King <linux@arm.linux.org.uk>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.1.0
