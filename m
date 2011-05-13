From: jdzheng@broadcom.com (JD (Jiandong) Zheng)
Date: Thu, 12 May 2011 17:19:51 -0700
Subject: [PATCH] bcmring: fix dma.c build error
Message-ID: <8628FE4E7912BF47A96AE7DD7BAC0AADE080FD2484@SJEXCHCCR02.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a missing header file to dma.c.

Signed-off-by: Jiandong Zheng <jdzheng@broadcom.com>
---
 arch/arm/mach-bcmring/dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-bcmring/dma.c b/arch/arm/mach-bcmring/dma.c
index d87ad30..58d237d 100644
--- a/arch/arm/mach-bcmring/dma.c
+++ b/arch/arm/mach-bcmring/dma.c
@@ -29,6 +29,7 @@
 #include <linux/irqreturn.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 
 #include <mach/timer.h>
 
-- 
1.7.4.1
