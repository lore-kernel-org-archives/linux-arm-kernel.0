From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  3 Oct 2017 10:52:59 +0530
Subject: [PATCH 3/4] dmaengine: bcm-sba-raid: Use common GPL comment header
In-Reply-To: <1507008180-27171-1-git-send-email-anup.patel@broadcom.com>
References: <1507008180-27171-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1507008180-27171-4-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the comment header of Broadcom SBA RAID driver
similar to the GPL comment header used across Broadcom driver
sources.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 409da59..3956a01 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -1,9 +1,14 @@
 /*
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
  */
 
 /*
-- 
2.7.4
