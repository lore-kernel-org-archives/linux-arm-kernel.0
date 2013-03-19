From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Mar 2013 11:19:31 +0900
Subject: [PATCH 09/14] irqchip: intc-irqpin: GPL header for platform data
In-Reply-To: <1363659576-6333-1-git-send-email-horms+renesas@verge.net.au>
References: <1363659576-6333-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363659576-6333-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add GPL header to platform data include file.

Signed-off-by: Magnus Damm <damm@opensource.se>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../linux/platform_data/irq-renesas-intc-irqpin.h   |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/platform_data/irq-renesas-intc-irqpin.h b/include/linux/platform_data/irq-renesas-intc-irqpin.h
index 00ccac3..e4cb911 100644
--- a/include/linux/platform_data/irq-renesas-intc-irqpin.h
+++ b/include/linux/platform_data/irq-renesas-intc-irqpin.h
@@ -1,3 +1,22 @@
+/*
+ * Renesas INTC External IRQ Pin Driver
+ *
+ *  Copyright (C) 2013 Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
 #ifndef __IRQ_RENESAS_INTC_IRQPIN_H__
 #define __IRQ_RENESAS_INTC_IRQPIN_H__
 
-- 
1.7.10.4
