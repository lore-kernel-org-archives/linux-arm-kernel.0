From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 18 Sep 2018 14:48:13 -0300
Subject: [PATCH 1/2] soc: imx: gpc: Switch to SPDX identifier
Message-ID: <1537292894-22728-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/soc/imx/gpc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index c1d0ffd..aa3729e 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -1,13 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2015-2017 Pengutronix, Lucas Stach <kernel@pengutronix.de>
  * Copyright 2011-2013 Freescale Semiconductor, Inc.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
  */
 
 #include <linux/clk.h>
-- 
2.7.4
