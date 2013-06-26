From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 26 Jun 2013 09:58:16 +0800
Subject: [PATCH -next] ARM: edma: remove duplicated include from edma.c
Message-ID: <CAPgLHd_j_JmDOsGSwLO_eBZnWteMzLVKJa93fY2iaSe31Ozo_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/common/edma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index a432e6c..39ad030 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -26,7 +26,6 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/edma.h>
-#include <linux/err.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
