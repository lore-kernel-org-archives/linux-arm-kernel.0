From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 Apr 2012 16:02:31 +0200
Subject: [PATCH 1/1] ARN: at91: fix rm9200ek flash size
Message-ID: <1334066551-5554-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flash size is 8MiB.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-rm9200ek.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 78ffc83..2b15b8a 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -103,7 +103,7 @@ static struct i2c_board_info __initdata ek_i2c_devices[] = {
 };
 
 #define EK_FLASH_BASE	AT91_CHIPSELECT_0
-#define EK_FLASH_SIZE	SZ_2M
+#define EK_FLASH_SIZE	SZ_8M
 
 static struct physmap_flash_data ek_flash_data = {
 	.width		= 2,
-- 
1.7.9.1
