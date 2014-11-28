From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 28 Nov 2014 21:32:48 +0100
Subject: [PATCH] arm: pxa: fix pxa27x device-tree support kconfig
Message-ID: <1417206768-5840-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the useless CPU_PXA27x non existing kconfig option.
The true options is PXA27x, which is already selected.

Reported-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 83efe91..5f71c06 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -6,7 +6,6 @@ comment "Intel/Marvell Dev Platforms (sorted by hardware release time)"
 
 config MACH_PXA27X_DT
 	bool "Support PXA27x platforms from device tree"
-	select CPU_PXA27x
 	select POWER_SUPPLY
 	select PXA27x
 	select USE_OF
-- 
2.1.0
