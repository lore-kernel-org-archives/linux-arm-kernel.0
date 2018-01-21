From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 21 Jan 2018 18:01:43 +0100
Subject: [PATCH] soc: actions: Convert to SPDX license identifiers
Message-ID: <20180121170143.29915-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace textual license notices with SPDX-License-Identifier lines.
Add an SPDX-License-Identifier for the Makefile.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 drivers/soc/actions/Makefile         | 2 ++
 drivers/soc/actions/owl-sps-helper.c | 6 +-----
 drivers/soc/actions/owl-sps.c        | 6 +-----
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/actions/Makefile b/drivers/soc/actions/Makefile
index 1e101b06bab1..4db9e7b050e5 100644
--- a/drivers/soc/actions/Makefile
+++ b/drivers/soc/actions/Makefile
@@ -1,2 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
 obj-$(CONFIG_OWL_PM_DOMAINS_HELPER) += owl-sps-helper.o
 obj-$(CONFIG_OWL_PM_DOMAINS) += owl-sps.o
diff --git a/drivers/soc/actions/owl-sps-helper.c b/drivers/soc/actions/owl-sps-helper.c
index 9d7a2c2b44ec..291a206d6f04 100644
--- a/drivers/soc/actions/owl-sps-helper.c
+++ b/drivers/soc/actions/owl-sps-helper.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Actions Semi Owl Smart Power System (SPS) shared helpers
  *
@@ -5,11 +6,6 @@
  * Author: Actions Semi, Inc.
  *
  * Copyright (c) 2017 Andreas F?rber
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/soc/actions/owl-sps.c b/drivers/soc/actions/owl-sps.c
index 8477f0f18e24..38b276e6f319 100644
--- a/drivers/soc/actions/owl-sps.c
+++ b/drivers/soc/actions/owl-sps.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Actions Semi Owl Smart Power System (SPS)
  *
@@ -5,11 +6,6 @@
  * Author: Actions Semi, Inc.
  *
  * Copyright (c) 2017 Andreas F?rber
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <linux/of_address.h>
-- 
2.13.6
