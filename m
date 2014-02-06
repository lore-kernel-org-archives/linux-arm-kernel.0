From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:19:06 +0900
Subject: [PATCH 14/21] ARM: shmobile: bockw: Sort Kconfig node's selections
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
Message-ID: <2b2fd2755182d43e149259330c7b1fe0aa3243d6.1391665225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index b624b5a..6f16983 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -207,11 +207,11 @@ config MACH_BOCKW
 	bool "BOCK-W platform"
 	depends on ARCH_R8A7778
 	select ARCH_REQUIRE_GPIOLIB
-	select RENESAS_INTC_IRQPIN
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select USE_OF
+	select RENESAS_INTC_IRQPIN
 	select SND_SOC_AK4554 if SND_SIMPLE_CARD
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select USE_OF
 
 config MACH_BOCKW_REFERENCE
 	bool "BOCK-W  - Reference Device Tree Implementation"
-- 
1.8.5.2
