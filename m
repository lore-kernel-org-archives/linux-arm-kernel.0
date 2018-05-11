From: s-anna@ti.com (Suman Anna)
Date: Fri, 11 May 2018 12:03:19 -0500
Subject: [PATCH 4/6] hwspinlock/sirf: Switch to SPDX license identifier
In-Reply-To: <20180511170321.2452-1-s-anna@ti.com>
References: <20180511170321.2452-1-s-anna@ti.com>
Message-ID: <20180511170321.2452-5-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the appropriate SPDX license identifier in the CSR's SIRF hardware
spinlock driver source file and drop the previous boilerplate license text.

Cc: Wei Chen <wei.chen@csr.com>
Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/sirf_hwspinlock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwspinlock/sirf_hwspinlock.c b/drivers/hwspinlock/sirf_hwspinlock.c
index 16018544d431..02ef6e543cd1 100644
--- a/drivers/hwspinlock/sirf_hwspinlock.c
+++ b/drivers/hwspinlock/sirf_hwspinlock.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SIRF hardware spinlock driver
  *
  * Copyright (c) 2015 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2.
  */
 
 #include <linux/kernel.h>
-- 
2.17.0
