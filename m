From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 24 Feb 2015 11:17:08 +0100
Subject: [PATCH v2 4/7] serial: imx: reformat and cleanup copyright header
In-Reply-To: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1424773031-19692-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix indention, remove old address of the FSF, remove in-file changelog,
mention Freescale.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 20d11363eff3..235c36522dd6 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1,13 +1,13 @@
 /*
- *  Driver for Motorola IMX serial ports
+ * Driver for Motorola/Freescale IMX serial ports
  *
- *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
+ * Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
  *
- *  Author: Sascha Hauer <sascha@saschahauer.de>
- *  Copyright (C) 2004 Pengutronix
+ * Author: Sascha Hauer <sascha@saschahauer.de>
+ * Copyright (C) 2004 Pengutronix
  *
- *  Copyright (C) 2009 emlix GmbH
- *  Author: Fabian Godehardt (added IrDA support for iMX)
+ * Author: Fabian Godehardt (added IrDA support for iMX)
+ * Copyright (C) 2009 emlix GmbH
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -18,13 +18,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- * [29-Mar-2005] Mike Lee
- * Added hardware handshake
  */
 
 #if defined(CONFIG_SERIAL_IMX_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-- 
2.1.4
