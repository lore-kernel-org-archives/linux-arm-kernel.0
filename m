From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:28 -0400
Subject: [PATCH 43/52] ARM: mach-spear*: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-43-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-spear3xx/spear300_evb.c |    2 +-
 arch/arm/mach-spear3xx/spear310_evb.c |    2 +-
 arch/arm/mach-spear3xx/spear320_evb.c |    2 +-
 arch/arm/mach-spear6xx/spear600_evb.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 69006f6..a5ff98e 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -64,7 +64,7 @@ static void __init spear300_evb_init(void)
 }
 
 MACHINE_START(SPEAR300, "ST-SPEAR300-EVB")
-	.boot_params	=	0x00000100,
+	.atag_offset	=	0x100,
 	.map_io		=	spear3xx_map_io,
 	.init_irq	=	spear3xx_init_irq,
 	.timer		=	&spear3xx_timer,
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index c8684ce..45d180d 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -70,7 +70,7 @@ static void __init spear310_evb_init(void)
 }
 
 MACHINE_START(SPEAR310, "ST-SPEAR310-EVB")
-	.boot_params	=	0x00000100,
+	.atag_offset	=	0x100,
 	.map_io		=	spear3xx_map_io,
 	.init_irq	=	spear3xx_init_irq,
 	.timer		=	&spear3xx_timer,
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index a12b353..2287984 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -68,7 +68,7 @@ static void __init spear320_evb_init(void)
 }
 
 MACHINE_START(SPEAR320, "ST-SPEAR320-EVB")
-	.boot_params	=	0x00000100,
+	.atag_offset	=	0x100,
 	.map_io		=	spear3xx_map_io,
 	.init_irq	=	spear3xx_init_irq,
 	.timer		=	&spear3xx_timer,
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index f19cefe..8238fe3 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -43,7 +43,7 @@ static void __init spear600_evb_init(void)
 }
 
 MACHINE_START(SPEAR600, "ST-SPEAR600-EVB")
-	.boot_params	=	0x00000100,
+	.atag_offset	=	0x100,
 	.map_io		=	spear6xx_map_io,
 	.init_irq	=	spear6xx_init_irq,
 	.timer		=	&spear6xx_timer,
-- 
1.7.4
