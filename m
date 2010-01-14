From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 14 Jan 2010 10:15:14 +0900
Subject: [PATCH] ARM: SAMSUNG: Add system.h file
Message-ID: <1263431714-2922-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds system.h file into plat-samsung.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/include/mach/system.h |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/mach/system.h

diff --git a/arch/arm/plat-samsung/include/mach/system.h b/arch/arm/plat-samsung/include/mach/system.h
new file mode 100644
index 0000000..596fe8d
--- /dev/null
+++ b/arch/arm/plat-samsung/include/mach/system.h
@@ -0,0 +1,26 @@
+/* linux/arch/arm/plat-samsung/include/mach/system.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Idle support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_SYSTEM_H
+#define __ASM_PLAT_SYSTEM_H __FILE__
+
+static void arch_idle(void)
+{
+	/* nothing here yet */
+}
+
+static void arch_reset(char mode, const char *cmd)
+{
+	/* nothing here yet */
+}
+
+#endif /* __ASM_PLAT_SYSTEM_H */
-- 
1.6.2.5
