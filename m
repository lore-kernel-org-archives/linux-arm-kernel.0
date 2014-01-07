From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  7 Jan 2014 17:48:03 +0900
Subject: [PATCH 3/8] ARM: shmobile: bockw: Sort Kconfig node's selections
In-Reply-To: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
References: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1389084488-25984-4-git-send-email-horms+renesas@verge.net.au>
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
1.8.4
