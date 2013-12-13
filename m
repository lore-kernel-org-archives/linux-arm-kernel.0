From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 14 Dec 2013 02:24:53 +0300
Subject: [PATCH] irq-gic: remove file name from heading comment
Message-ID: <201312140224.53928.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

File names in the heading comments  fell out of favor long ago, and this one
weren't even changed when the driver was moved from arch/arm/common/, so remove
it at last...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'irq/core' branch of the 'tip.git' repo.

 drivers/irqchip/irq-gic.c |    2 --
 1 file changed, 2 deletions(-)

Index: tip/drivers/irqchip/irq-gic.c
===================================================================
--- tip.orig/drivers/irqchip/irq-gic.c
+++ tip/drivers/irqchip/irq-gic.c
@@ -1,6 +1,4 @@
 /*
- *  linux/arch/arm/common/gic.c
- *
  *  Copyright (C) 2002 ARM Limited, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
