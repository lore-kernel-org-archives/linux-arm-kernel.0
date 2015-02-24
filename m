From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 24 Feb 2015 11:17:09 +0100
Subject: [PATCH v2 5/7] serial: imx: fix comment about which machines use the
 i.MX21 type
In-Reply-To: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1424773031-19692-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 235c36522dd6..e74dd74d84d0 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -182,7 +182,7 @@
 
 #define UART_NR 8
 
-/* i.mx21 type uart runs on all i.mx except i.mx1 */
+/* i.MX21 type uart runs on all i.mx except i.MX1 and i.MX6q */
 enum imx_uart_type {
 	IMX1_UART,
 	IMX21_UART,
-- 
2.1.4
