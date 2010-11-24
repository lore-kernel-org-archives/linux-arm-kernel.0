From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 24 Nov 2010 15:55:38 +0100
Subject: [PATCH 4/7 v2] at91: rename rm9200ek and rm9200dk board file name
In-Reply-To: <20101124143448.GH11909@game.jcrosoft.org>
References: <20101124143448.GH11909@game.jcrosoft.org>
Message-ID: <1290610541-29255-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

to be a few more concistant with the other boards

as ek is for evaluation kit and dk for development kit

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Andrew Victor <linux@maxim.org.za>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Makefile                        |    4 ++--
 .../arm/mach-at91/{board-dk.c => board-rm9200dk.c} |    2 +-
 .../arm/mach-at91/{board-ek.c => board-rm9200ek.c} |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm/mach-at91/{board-dk.c => board-rm9200dk.c} (99%)
 rename arch/arm/mach-at91/{board-ek.c => board-rm9200ek.c} (99%)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 821eb84..62d686f 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -24,8 +24,8 @@ obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
 
 # AT91RM9200 board-specific support
 obj-$(CONFIG_MACH_ONEARM)	+= board-1arm.o
-obj-$(CONFIG_ARCH_AT91RM9200DK)	+= board-dk.o
-obj-$(CONFIG_MACH_AT91RM9200EK)	+= board-ek.o
+obj-$(CONFIG_ARCH_AT91RM9200DK)	+= board-rm9200dk.o
+obj-$(CONFIG_MACH_AT91RM9200EK)	+= board-rm9200ek.o
 obj-$(CONFIG_MACH_CSB337)	+= board-csb337.o
 obj-$(CONFIG_MACH_CSB637)	+= board-csb637.o
 obj-$(CONFIG_MACH_CARMEVA)	+= board-carmeva.o
diff --git a/arch/arm/mach-at91/board-dk.c b/arch/arm/mach-at91/board-rm9200dk.c
similarity index 99%
rename from arch/arm/mach-at91/board-dk.c
rename to arch/arm/mach-at91/board-rm9200dk.c
index 16dfd0c..4c1047c 100644
--- a/arch/arm/mach-at91/board-dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-at91/board-dk.c
+ * linux/arch/arm/mach-at91/board-rm9200dk.c
  *
  *  Copyright (C) 2005 SAN People
  *
diff --git a/arch/arm/mach-at91/board-ek.c b/arch/arm/mach-at91/board-rm9200ek.c
similarity index 99%
rename from arch/arm/mach-at91/board-ek.c
rename to arch/arm/mach-at91/board-rm9200ek.c
index 6203cdf..9df1be8 100644
--- a/arch/arm/mach-at91/board-ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-at91/board-ek.c
+ * linux/arch/arm/mach-at91/board-rm9200ek.c
  *
  *  Copyright (C) 2005 SAN People
  *
-- 
1.7.1
