From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 20:49:06 +0200
Subject: [PATCH] at91/yl-9200: Fix section mismatch
Message-ID: <1318790946-21042-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-yl-9200.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index ecb8378..0b7c7de 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -391,7 +391,7 @@ static struct spi_board_info yl9200_spi_devices[] = {
 #include <video/s1d13xxxfb.h>
 
 
-static void __init yl9200_init_video(void)
+static void yl9200_init_video(void)
 {
 	/* NWAIT Signal */
 	at91_set_A_periph(AT91_PIN_PC6, 0);
-- 
1.7.7
