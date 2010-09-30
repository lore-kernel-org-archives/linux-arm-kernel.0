From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 13:48:32 +0900
Subject: [PATCH 3/7] ARM: Samsung: Use the correct I2C2 interrupt
Message-ID: <20100930044832.GA16905@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Use the correct I2C2 interrupt.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/dev-i2c2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-i2c2.c b/arch/arm/plat-samsung/dev-i2c2.c
index 07036de..ff4ba69 100644
--- a/arch/arm/plat-samsung/dev-i2c2.c
+++ b/arch/arm/plat-samsung/dev-i2c2.c
@@ -32,8 +32,8 @@ static struct resource s3c_i2c_resource[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start = IRQ_CAN0,
-		.end   = IRQ_CAN0,
+		.start = IRQ_IIC2,
+		.end   = IRQ_IIC2,
 		.flags = IORESOURCE_IRQ,
 	},
 };
-- 
1.5.3.3
