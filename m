From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 15 Feb 2014 12:05:30 +0400
Subject: [PATCH 1/4] ARM: clps711x: autcpu12: Fix incorrect NAND CLE GPIO
Message-ID: <1392451533-12858-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-autcpu12.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index f8d71a8..5f83113 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -73,7 +73,7 @@
 #define AUTCPU12_SMC_NCE	(AUTCPU12_MMGPIO_BASE + 0) /* Bit 0 */
 #define AUTCPU12_SMC_RDY	CLPS711X_GPIO(1, 2)
 #define AUTCPU12_SMC_ALE	CLPS711X_GPIO(1, 3)
-#define AUTCPU12_SMC_CLE	CLPS711X_GPIO(1, 3)
+#define AUTCPU12_SMC_CLE	CLPS711X_GPIO(1, 4)
 
 /* LCD contrast digital potentiometer */
 #define AUTCPU12_DPOT_CS	CLPS711X_GPIO(4, 0)
-- 
1.8.3.2
