From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 28 Jun 2010 16:39:13 +1200
Subject: [PATCH 1/3] AT91: Define NR_BUILTIN_GPIO
In-Reply-To: <1277699955-9931-1-git-send-email-ryan@bluewatersys.com>
References: <1277699955-9931-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1277699955-9931-2-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add definition for NR_BUILTIN_GPIO for AT91 family

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/include/mach/gpio.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/gpio.h b/arch/arm/mach-at91/include/mach/gpio.h
index 04c91e3..bfdd8ab 100644
--- a/arch/arm/mach-at91/include/mach/gpio.h
+++ b/arch/arm/mach-at91/include/mach/gpio.h
@@ -19,6 +19,7 @@
 #define PIN_BASE		NR_AIC_IRQS
 
 #define MAX_GPIO_BANKS		5
+#define NR_BUILTIN_GPIO		(PIN_BASE + (MAX_GPIO_BANKS * 32))
 
 /* these pin numbers double as IRQ numbers, like AT91xxx_ID_* values */
 
-- 
1.5.5.1
