From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Apr 2012 11:20:51 +0200
Subject: [PATCH 07/12] ARM: at91: fix rm9200ek flash size
In-Reply-To: <cover.1334567594.git.nicolas.ferre@atmel.com>
References: <cover.1334567594.git.nicolas.ferre@atmel.com>
Message-ID: <bf66b0d1dad30cc1241dc4e3ac193251a4694f5c.1334567594.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

The flash size is 8MiB.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-rm9200ek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 11cbaa8..b2e4fe2 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -117,7 +117,7 @@ static struct i2c_board_info __initdata ek_i2c_devices[] = {
 };
 
 #define EK_FLASH_BASE	AT91_CHIPSELECT_0
-#define EK_FLASH_SIZE	SZ_2M
+#define EK_FLASH_SIZE	SZ_8M
 
 static struct physmap_flash_data ek_flash_data = {
 	.width		= 2,
-- 
1.7.10
