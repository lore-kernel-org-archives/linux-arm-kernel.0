From: david.lanzendoerfer@o2s.ch (David =?utf-8?q?Lanzend=C3=B6rfer?=)
Date: Sun, 16 Feb 2014 06:11:21 +0100
Subject: [PATCH v6 3/8] ARM: sunxi: clk: export clk_sunxi_mmc_phase_control
In-Reply-To: <20140216050933.728.25526.stgit@dizzy-6.o2s.ch>
References: <20140216050933.728.25526.stgit@dizzy-6.o2s.ch>
Message-ID: <20140216051120.728.27434.stgit@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/linux/clk/sunxi.h |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 include/linux/clk/sunxi.h

diff --git a/include/linux/clk/sunxi.h b/include/linux/clk/sunxi.h
new file mode 100644
index 0000000..1ef5c89
--- /dev/null
+++ b/include/linux/clk/sunxi.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright 2013 - Hans de Goede <hdegoede@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_CLK_SUNXI_H_
+#define __LINUX_CLK_SUNXI_H_
+
+#include <linux/clk.h>
+
+void clk_sunxi_mmc_phase_control(struct clk_hw *hw, u8 sample, u8 output);
+
+#endif
