From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  3 Oct 2017 10:51:51 +0530
Subject: [PATCH 4/5] mailbox: bcm-flexrm-mailbox: Use common GPL comment header
In-Reply-To: <1507008112-27117-1-git-send-email-anup.patel@broadcom.com>
References: <1507008112-27117-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1507008112-27117-5-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the comment header of Broadcom FlexRM driver
similar to the GPL comment header used across Broadcom driver
sources.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index e0443ae..a8cf433 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1,10 +1,18 @@
-/* Broadcom FlexRM Mailbox Driver
- *
+/*
  * Copyright (C) 2017 Broadcom
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
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
+/*
+ * Broadcom FlexRM Mailbox Driver
  *
  * Each Broadcom FlexSparx4 offload engine is implemented as an
  * extension to Broadcom FlexRM ring manager. The FlexRM ring
-- 
2.7.4
