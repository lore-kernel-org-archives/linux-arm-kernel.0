From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 24 Jun 2013 11:08:46 +0200
Subject: [PATCH 2/3] ARM: at91/PMC: at91sam9n12 family have a PLLB
In-Reply-To: <cover.1372064763.git.nicolas.ferre@atmel.com>
References: <cover.1372064763.git.nicolas.ferre@atmel.com>
Message-ID: <1a09cb9b88027ff0f5226d977786275f0463b930.1372064763.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/clock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 085a79d..978de42 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -75,7 +75,6 @@ EXPORT_SYMBOL_GPL(at91_pmc_base);
 #define cpu_has_pllb()		(!(cpu_is_at91sam9rl() \
 				|| cpu_is_at91sam9g45() \
 				|| cpu_is_at91sam9x5() \
-				|| cpu_is_at91sam9n12() \
 				|| cpu_is_sama5d3()))
 
 #define cpu_has_upll()		(cpu_is_at91sam9g45() \
-- 
1.8.2.2
