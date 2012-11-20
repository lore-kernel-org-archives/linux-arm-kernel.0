From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Nov 2012 20:01:11 +0100
Subject: [PATCH] clk: add GPLv2 headers to the Versatile clock files
Message-ID: <1353438071-27079-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPLv2 headers were missing and the subsystem maintainer likes
them so put them in. I am the copyright holder, so explicitly
licensing these under the GPLv2.

Reported-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/versatile/clk-icst.c       | 6 ++++++
 drivers/clk/versatile/clk-integrator.c | 8 ++++++++
 drivers/clk/versatile/clk-realview.c   | 8 ++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index f555b50..23d2d7e 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -3,6 +3,12 @@
  * We wrap the custom interface from <asm/hardware/icst.h> into the generic
  * clock framework.
  *
+ * Copyright (C) 2012 Linus Walleij
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
  * TODO: when all ARM reference designs are migrated to generic clocks, the
  * ICST clock code from the ARM tree should probably be merged into this
  * file.
diff --git a/drivers/clk/versatile/clk-integrator.c b/drivers/clk/versatile/clk-integrator.c
index 5aa6ab9..d7cf1ba 100644
--- a/drivers/clk/versatile/clk-integrator.c
+++ b/drivers/clk/versatile/clk-integrator.c
@@ -1,3 +1,11 @@
+/*
+ * Clock driver for the ARM Integrator/AP and Integrator/CP boards
+ * Copyright (C) 2012 Linus Walleij
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
diff --git a/drivers/clk/versatile/clk-realview.c b/drivers/clk/versatile/clk-realview.c
index e21a99c..fd2dbdb 100644
--- a/drivers/clk/versatile/clk-realview.c
+++ b/drivers/clk/versatile/clk-realview.c
@@ -1,3 +1,11 @@
+/*
+ * Clock driver for the ARM RealView boards
+ * Copyright (C) 2012 Linus Walleij
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/err.h>
-- 
1.7.11.7
