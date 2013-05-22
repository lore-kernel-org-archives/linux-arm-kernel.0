From: avinashphilip@ti.com (Philip Avinash)
Date: Wed, 22 May 2013 12:40:24 +0530
Subject: [PATCH 01/11] ARM: davinci: GPIO: Add platform data structure
In-Reply-To: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1369206634-6778-2-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: KV Sujith <sujithkv@ti.com>

Add struct davinci_gpio_platform_data davinci gpio module.

Signed-off-by: KV Sujith <sujithkv@ti.com>
Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
 include/linux/platform_data/gpio-davinci.h |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 include/linux/platform_data/gpio-davinci.h

diff --git a/include/linux/platform_data/gpio-davinci.h b/include/linux/platform_data/gpio-davinci.h
new file mode 100644
index 0000000..f1c8277
--- /dev/null
+++ b/include/linux/platform_data/gpio-davinci.h
@@ -0,0 +1,27 @@
+/*
+ * gpio-davinci.h
+ *
+ * DaVinci GPIO Platform Related Defines
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ASM_ARCH_DAVINCI_GPIO_H
+#define __ASM_ARCH_DAVINCI_GPIO_H
+
+struct davinci_gpio_platform_data {
+	u32	ngpio;
+	u32	gpio_unbanked;
+	u32	intc_irq_num;
+};
+
+#endif
-- 
1.7.9.5
