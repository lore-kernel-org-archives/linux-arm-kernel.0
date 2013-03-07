From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  7 Mar 2013 15:21:53 +0100
Subject: [PATCH 3/3] ARM: at91: renamme rm9200 dt file
In-Reply-To: <1362666113-16434-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130307130842.GA4590@game.jcrosoft.org>
 <1362666113-16434-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1362666113-16434-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

to follow the same scheme board-dt-<socs>.c

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/Makefile                                 |    2 +-
 arch/arm/mach-at91/{board-rm9200-dt.c => board-dt-rm9200.c} |    0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/mach-at91/{board-rm9200-dt.c => board-dt-rm9200.c} (100%)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 5eca35a..505fed9 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -87,7 +87,7 @@ obj-$(CONFIG_MACH_SNAPPER_9260)	+= board-snapper9260.o
 obj-$(CONFIG_MACH_AT91SAM9M10G45EK) += board-sam9m10g45ek.o
 
 # AT91SAM board with device-tree
-obj-$(CONFIG_MACH_AT91RM9200_DT) += board-rm9200-dt.o
+obj-$(CONFIG_MACH_AT91RM9200_DT) += board-dt-rm9200.o
 obj-$(CONFIG_MACH_AT91SAM9_DT) += board-dt-sam9.o
 
 # AT91X40 board-specific support
diff --git a/arch/arm/mach-at91/board-rm9200-dt.c b/arch/arm/mach-at91/board-dt-rm9200.c
similarity index 100%
rename from arch/arm/mach-at91/board-rm9200-dt.c
rename to arch/arm/mach-at91/board-dt-rm9200.c
-- 
1.7.10.4
