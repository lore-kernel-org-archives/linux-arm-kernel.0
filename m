From: thomas.ab@samsung.com (Thomas Abraham)
Date: Thu, 14 Apr 2011 15:39:21 +0530
Subject: [PATCH] ARM: Remove clkdev.o build in arch/arm/common/Makefile
Message-ID: <1302775761-27139-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clkdev.c is moved to drivers/clk. So build for clkdev.o can
be removed from arch/arm/common/Makefile.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/common/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e7521bc..6ea9b6f 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -16,5 +16,4 @@ obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_ARCH_IXP2000)	+= uengine.o
 obj-$(CONFIG_ARCH_IXP23XX)	+= uengine.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
-obj-$(CONFIG_COMMON_CLKDEV)	+= clkdev.o
 obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
-- 
1.6.6.rc2
