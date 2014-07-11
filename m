From: sdu.liu@huawei.com (Liu Hua)
Date: Fri, 11 Jul 2014 14:46:16 +0800
Subject: [RFC PATCH 1/2] irqchip: GIC: introduce ICPIDR2 register interface
In-Reply-To: <1405061177-43834-1-git-send-email-sdu.liu@huawei.com>
References: <1405061177-43834-1-git-send-email-sdu.liu@huawei.com>
Message-ID: <1405061177-43834-2-git-send-email-sdu.liu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peripheral ID2 Register provides a four-bit architecturally-defined
architecture revision field. So we can identify the GIC verison from
this register. It is useful sometimes.

Signed-off-by: Liu Hua <sdu.liu@huawei.com>
---
 include/linux/irqchip/arm-gic.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 45e2d8c..872a562 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -38,6 +38,7 @@
 #define GIC_DIST_SOFTINT		0xf00
 #define GIC_DIST_SGI_PENDING_CLEAR	0xf10
 #define GIC_DIST_SGI_PENDING_SET	0xf20
+#define GIC_DIST_ICPIDR2		0xfe8
 
 #define GICH_HCR			0x0
 #define GICH_VTR			0x4
-- 
1.9.0
