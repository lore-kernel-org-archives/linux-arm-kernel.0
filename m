From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:40 +0900
Subject: [PATCH 9/9] ARM: shmobile: r8a7791 is now called "R-Car M2-W"
In-Reply-To: <cover.1409792454.git.horms+renesas@verge.net.au>
References: <cover.1409792454.git.horms+renesas@verge.net.au>
Message-ID: <13298fbbdb3f6a0ef55419dc048e064c7a7b0ef8.1409792454.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As per recent revisions of the datasheet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 6283ff2..efc49da 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -59,7 +59,7 @@ config ARCH_R8A7790
 	select ARCH_RCAR_GEN2
 
 config ARCH_R8A7791
-	bool "R-Car M2 (R8A77910)"
+	bool "R-Car M2-W (R8A77910)"
 	select ARCH_RCAR_GEN2
 
 comment "Renesas ARM SoCs Board Type"
@@ -141,7 +141,7 @@ config ARCH_R8A7790
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 config ARCH_R8A7791
-	bool "R-Car M2 (R8A77910)"
+	bool "R-Car M2-W (R8A77910)"
 	select ARCH_RCAR_GEN2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-- 
2.0.1
