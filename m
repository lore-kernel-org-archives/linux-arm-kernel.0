From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 24 Jun 2013 11:08:47 +0200
Subject: [PATCH 3/3] ARM: at91/PMC: at91sam9n12 family has USB HS feature
In-Reply-To: <cover.1372064763.git.nicolas.ferre@atmel.com>
References: <cover.1372064763.git.nicolas.ferre@atmel.com>
Message-ID: <a3b28f9041482ff60ed0b1b7a6f11d0b1beb5163.1372064763.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/clock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 978de42..1b9bbba 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -88,6 +88,7 @@ EXPORT_SYMBOL_GPL(at91_pmc_base);
 #define cpu_has_udpfs()		(!(cpu_is_at91sam9rl() \
 				|| cpu_is_at91sam9g45() \
 				|| cpu_is_at91sam9x5() \
+				|| cpu_is_at91sam9n12() \
 				|| cpu_is_sama5d3()))
 
 #define cpu_has_plladiv2()	(cpu_is_at91sam9g45() \
-- 
1.8.2.2
