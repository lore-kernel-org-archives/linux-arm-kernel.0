From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 16 Mar 2015 08:03:15 +0900
Subject: [PATCH 1/3] ARM: shmobile: Remove stray closing parenthesis in debug
 description
In-Reply-To: <cover.1426456752.git.horms+renesas@verge.net.au>
References: <cover.1426456752.git.horms+renesas@verge.net.au>
Message-ID: <e2fd51b7e1742b82529a39107ed59ac0da69321d.1426456752.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Remove the stray closing parenthesis in the config description for the
DEBUG_RCAR_GEN2_SCIF0 option.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 970de75..f2aa6c7 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -806,7 +806,7 @@ choice
 		  via SCIF2 on Renesas R-Car H1 (R8A7779).
 
 	config DEBUG_RCAR_GEN2_SCIF0
-		bool "Kernel low-level debugging messages via SCIF0 on R8A7790/R8A7791/R8A7793)"
+		bool "Kernel low-level debugging messages via SCIF0 on R8A7790/R8A7791/R8A7793"
 		depends on ARCH_R8A7790 || ARCH_R8A7791 || ARCH_R8A7793
 		help
 		  Say Y here if you want kernel low-level debugging support
-- 
2.1.4
