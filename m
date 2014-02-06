From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Thu,  6 Feb 2014 10:55:35 +0530
Subject: [PATCH] ARM: davinci: fix typo
Message-ID: <1391664335-4752-1-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch fixes a typo in mach/hardware.h, by
replacing "ths" to "this".

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 arch/arm/mach-davinci/include/mach/hardware.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/include/mach/hardware.h b/arch/arm/mach-davinci/include/mach/hardware.h
index 16bb422..8a5d843 100644
--- a/arch/arm/mach-davinci/include/mach/hardware.h
+++ b/arch/arm/mach-davinci/include/mach/hardware.h
@@ -12,7 +12,7 @@
 #define __ASM_ARCH_HARDWARE_H
 
 /*
- * Before you add anything to ths file:
+ * Before you add anything to this file:
  *
  * This header is for defines common to ALL DaVinci family chips.
  * Anything that is chip specific should go in <chipname>.h,
-- 
1.7.9.5
