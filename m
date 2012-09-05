From: loic.pallardy-ext@stericsson.com (Loic Pallardy)
Date: Wed, 5 Sep 2012 11:59:04 +0200
Subject: [PATCH 08/17] arm: ux500: update DB internal irq nb
In-Reply-To: <1346839153-6465-1-git-send-email-loic.pallardy-ext@stericsson.com>
References: <1346839153-6465-1-git-send-email-loic.pallardy-ext@stericsson.com>
Message-ID: <1346839153-6465-9-git-send-email-loic.pallardy-ext@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support DB9540 chipset, nb internal irq must be updated.

Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/include/mach/irqs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index fc77b42..c1a6908 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -24,7 +24,7 @@
  */
 #define IRQ_MTU0		(IRQ_SHPI_START + 4)
 
-#define DBX500_NR_INTERNAL_IRQS		166
+#define DBX500_NR_INTERNAL_IRQS		(IRQ_SHPI_START + 224)
 
 /* After chip-specific IRQ numbers we have the GPIO ones */
 #define NOMADIK_NR_GPIO			288
-- 
1.7.11.1
