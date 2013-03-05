From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 05 Mar 2013 10:13:39 +0100
Subject: [PATCH] ARM: SPEAr13xx: Fix typo "ARCH_HAVE_CPUFREQ"
Message-ID: <1362474819.16460.63.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do what commit f12a500e4adcc0961803e54b5ed1e74275d399f1
("ARM: SPEAr13xx: Enable CONFIG_ARCH_HAS_CPUFREQ") wanted to do.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/arm/plat-spear/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-spear/Kconfig b/arch/arm/plat-spear/Kconfig
index 739d016..8a08c31 100644
--- a/arch/arm/plat-spear/Kconfig
+++ b/arch/arm/plat-spear/Kconfig
@@ -10,7 +10,7 @@ choice
 
 config ARCH_SPEAR13XX
 	bool "ST SPEAr13xx with Device Tree"
-	select ARCH_HAVE_CPUFREQ
+	select ARCH_HAS_CPUFREQ
 	select ARM_GIC
 	select CPU_V7
 	select GPIO_SPEAR_SPICS
-- 
1.7.11.7
