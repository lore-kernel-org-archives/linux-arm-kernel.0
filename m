From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 16 Apr 2012 11:20:49 +0200
Subject: [PATCH 05/12] ARM: at91: fix typo in at91_pmc_base assembly
 declaration
In-Reply-To: <cover.1334567594.git.nicolas.ferre@atmel.com>
References: <cover.1334567594.git.nicolas.ferre@atmel.com>
Message-ID: <67f3af402aebb0098998d3bbebda2fb44aa3a081.1334567594.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/at91_pmc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_pmc.h b/arch/arm/mach-at91/include/mach/at91_pmc.h
index 3660478..ea2c57a 100644
--- a/arch/arm/mach-at91/include/mach/at91_pmc.h
+++ b/arch/arm/mach-at91/include/mach/at91_pmc.h
@@ -25,7 +25,7 @@ extern void __iomem *at91_pmc_base;
 #define at91_pmc_write(field, value) \
 	__raw_writel(value, at91_pmc_base + field)
 #else
-.extern at91_aic_base
+.extern at91_pmc_base
 #endif
 
 #define	AT91_PMC_SCER		0x00			/* System Clock Enable Register */
-- 
1.7.10
