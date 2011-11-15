From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 15 Nov 2011 21:40:41 +0100
Subject: [PATCH 08/13 v2] ARM: at91: drop CCFG
In-Reply-To: <20111113180954.GD15318@game.jcrosoft.org>
References: <20111113180954.GD15318@game.jcrosoft.org>
Message-ID: <1321389646-24112-10-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

never used in the kernel

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/at91cap9.h    |    1 -
 arch/arm/mach-at91/include/mach/at91sam9260.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9263.h |    1 -
 arch/arm/mach-at91/include/mach/at91sam9rl.h  |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
index d7d0b68..cd19f050 100644
--- a/arch/arm/mach-at91/include/mach/at91cap9.h
+++ b/arch/arm/mach-at91/include/mach/at91cap9.h
@@ -82,7 +82,6 @@
 #define AT91_BCRAMC	(0xffffe400 - AT91_BASE_SYS)
 #define AT91_DDRSDRC0	(0xffffe600 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffea00 - AT91_BASE_SYS)
-#define AT91_CCFG	(0xffffeb10 - AT91_BASE_SYS)
 #define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index e55ab6a..f964cfa 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -82,7 +82,6 @@
  */
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
-#define AT91_CCFG	(0xffffef10 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
index b827ff7..a62a3a8 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9263.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
@@ -77,7 +77,6 @@
 #define AT91_SDRAMC0	(0xffffe200 - AT91_BASE_SYS)
 #define AT91_SDRAMC1	(0xffffe800 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffec00 - AT91_BASE_SYS)
-#define AT91_CCFG	(0xffffed10 - AT91_BASE_SYS)
 #define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
index 846139d..c945d4d 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
@@ -71,7 +71,6 @@
  */
 #define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
 #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
-#define AT91_CCFG	(0xffffef10 - AT91_BASE_SYS)
 #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
 #define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
 #define AT91_PMC	(0xfffffc00 - AT91_BASE_SYS)
-- 
1.7.7
