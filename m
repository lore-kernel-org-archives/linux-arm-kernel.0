From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Tue, 3 Jan 2012 10:39:18 -0800
Subject: [PATCH] ARM/bcmring: missing sched.h inclusion in dma.c
Message-ID: <4F034B56.4060704@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add including of sched.h to fix build error.

This patch was submitted a couple of times last year but unfortunately 
got lost.

Signed-off-by: Jiandong Zheng <jdzheng@broadcom.com>
---
  arch/arm/mach-bcmring/dma.c |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-bcmring/dma.c b/arch/arm/mach-bcmring/dma.c
index 0ca0005..ab109ff 100644
--- a/arch/arm/mach-bcmring/dma.c
+++ b/arch/arm/mach-bcmring/dma.c
@@ -24,6 +24,7 @@

  #include <linux/module.h>
  #include <linux/device.h>
+#include <linux/sched.h>
  #include <linux/dma-mapping.h>
  #include <linux/interrupt.h>
  #include <linux/irqreturn.h>
-- 
1.7.5.4
