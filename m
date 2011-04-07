From: justinmattock@gmail.com (Justin P. Mattock)
Date: Thu,  7 Apr 2011 16:38:49 -0700
Subject: =?UTF-8?q?=5BPATCH=201/5=20V2=5Darch=3Acommon=3AMakefile=20Remove=20unused=20config=20in=20the=20Makefile=2E?=
Message-ID: <1302219529-8864-1-git-send-email-justinmattock@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch below removes an unused config variable found by using a kernel
cleanup script.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/common/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e7521bca..6ea9b6f 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -16,5 +16,4 @@ obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_ARCH_IXP2000)	+= uengine.o
 obj-$(CONFIG_ARCH_IXP23XX)	+= uengine.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
-obj-$(CONFIG_COMMON_CLKDEV)	+= clkdev.o
 obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
-- 
1.7.4.2
