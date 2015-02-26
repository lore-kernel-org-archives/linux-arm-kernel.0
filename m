From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 26 Feb 2015 11:29:35 +0100
Subject: [PATCH] ARM: shmobile: Remove stray closing parenthesis in debug
 description
Message-ID: <1424946575-7030-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the stray closing parenthesis in the config description for the
DEBUG_RCAR_GEN2_SCIF0 option.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6e55ed915332e8b6..b8e719476402560a 100644
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
1.9.1
