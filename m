From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 19 Oct 2010 16:28:16 +0200
Subject: [PATCH 1/2] ARM: pxa: Fix number of IRQs on Balloon3
Message-ID: <1287498497-11251-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/include/mach/balloon3.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h b/arch/arm/mach-pxa/include/mach/balloon3.h
index 561562b..3506da1 100644
--- a/arch/arm/mach-pxa/include/mach/balloon3.h
+++ b/arch/arm/mach-pxa/include/mach/balloon3.h
@@ -174,7 +174,7 @@ enum balloon3_features {
 #define BALLOON3_CODEC_IRQ	IRQ_GPIO(BALLOON3_GPIO_CODEC_IRQ)
 #define BALLOON3_S0_CD_IRQ	IRQ_GPIO(BALLOON3_GPIO_S0_CD)
 
-#define BALLOON3_NR_IRQS	(IRQ_BOARD_START + 4)
+#define BALLOON3_NR_IRQS	(IRQ_BOARD_START + 16)
 
 extern int balloon3_has(enum balloon3_features feature);
 
-- 
1.7.1
