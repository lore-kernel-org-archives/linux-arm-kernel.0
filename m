From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 10 Dec 2012 16:25:42 +0100
Subject: [RESEND PATCH 5/5] cpufreq: dbx500: Update file header
In-Reply-To: <1355153142-9534-1-git-send-email-ulf.hansson@stericsson.com>
References: <1355153142-9534-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1355153142-9534-6-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

Real simple patch to extend the ST-Ericsson copyright date and
remove unnecessary extra commented lines.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpufreq/dbx500-cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index d4cb782..047fc4f 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -1,13 +1,13 @@
 /*
  * Copyright (C) STMicroelectronics 2009
- * Copyright (C) ST-Ericsson SA 2010
+ * Copyright (C) ST-Ericsson SA 2010-2012
  *
  * License Terms: GNU General Public License v2
  * Author: Sundar Iyer <sundar.iyer@stericsson.com>
  * Author: Martin Persson <martin.persson@stericsson.com>
  * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
- *
  */
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/cpufreq.h>
-- 
1.7.10
