From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 18 Sep 2018 14:48:14 -0300
Subject: [PATCH 2/2] soc: imx: gpcv2: Switch to SPDX identifier
In-Reply-To: <1537292894-22728-1-git-send-email-festevam@gmail.com>
References: <1537292894-22728-1-git-send-email-festevam@gmail.com>
Message-ID: <1537292894-22728-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 938103a..e7b5994 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2017 Impinj, Inc
  * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
@@ -5,13 +6,6 @@
  * Based on the code of analogus driver:
  *
  * Copyright 2015-2017 Pengutronix, Lucas Stach <kernel@pengutronix.de>
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
  */
 
 #include <linux/of_device.h>
-- 
2.7.4
