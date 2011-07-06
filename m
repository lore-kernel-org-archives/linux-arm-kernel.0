From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:55 -0400
Subject: [PATCH 10/52] ARM: mach-gemini: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-10-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-gemini/board-nas4220b.c |    2 +-
 arch/arm/mach-gemini/board-rut1xx.c   |    2 +-
 arch/arm/mach-gemini/board-wbd111.c   |    2 +-
 arch/arm/mach-gemini/board-wbd222.c   |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-gemini/board-nas4220b.c b/arch/arm/mach-gemini/board-nas4220b.c
index 0cf7a07..5927d3c 100644
--- a/arch/arm/mach-gemini/board-nas4220b.c
+++ b/arch/arm/mach-gemini/board-nas4220b.c
@@ -102,7 +102,7 @@ static void __init ib4220b_init(void)
 }
 
 MACHINE_START(NAS4220B, "Raidsonic NAS IB-4220-B")
-	.boot_params	= 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= gemini_map_io,
 	.init_irq	= gemini_init_irq,
 	.timer		= &ib4220b_timer,
diff --git a/arch/arm/mach-gemini/board-rut1xx.c b/arch/arm/mach-gemini/board-rut1xx.c
index 4fa09af..cd7437a 100644
--- a/arch/arm/mach-gemini/board-rut1xx.c
+++ b/arch/arm/mach-gemini/board-rut1xx.c
@@ -86,7 +86,7 @@ static void __init rut1xx_init(void)
 }
 
 MACHINE_START(RUT100, "Teltonika RUT100")
-	.boot_params	= 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= gemini_map_io,
 	.init_irq	= gemini_init_irq,
 	.timer		= &rut1xx_timer,
diff --git a/arch/arm/mach-gemini/board-wbd111.c b/arch/arm/mach-gemini/board-wbd111.c
index 88cc422..a367880 100644
--- a/arch/arm/mach-gemini/board-wbd111.c
+++ b/arch/arm/mach-gemini/board-wbd111.c
@@ -129,7 +129,7 @@ static void __init wbd111_init(void)
 }
 
 MACHINE_START(WBD111, "Wiliboard WBD-111")
-	.boot_params	= 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= gemini_map_io,
 	.init_irq	= gemini_init_irq,
 	.timer		= &wbd111_timer,
diff --git a/arch/arm/mach-gemini/board-wbd222.c b/arch/arm/mach-gemini/board-wbd222.c
index 3a22034..f382811 100644
--- a/arch/arm/mach-gemini/board-wbd222.c
+++ b/arch/arm/mach-gemini/board-wbd222.c
@@ -129,7 +129,7 @@ static void __init wbd222_init(void)
 }
 
 MACHINE_START(WBD222, "Wiliboard WBD-222")
-	.boot_params	= 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= gemini_map_io,
 	.init_irq	= gemini_init_irq,
 	.timer		= &wbd222_timer,
-- 
1.7.4
