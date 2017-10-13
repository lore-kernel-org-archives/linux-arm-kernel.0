From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Fri, 13 Oct 2017 11:01:55 +0200
Subject: [PATCH v2 11/16] serial: mvebu-uart: augment the maximum number of
 ports
In-Reply-To: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
Message-ID: <20171013090200.31034-12-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A3700 boards may have up to two UART ports. Set the new limit to two
maximum UART ports.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/tty/serial/mvebu-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index d0e749f6f052..1074054ee5be 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -74,7 +74,7 @@
 #define UART_BRDV		0x10
 #define  BRDV_BAUD_MASK         0x3FF
 
-#define MVEBU_NR_UARTS		1
+#define MVEBU_NR_UARTS		2
 
 #define MVEBU_UART_TYPE		"mvebu-uart"
 #define DRIVER_NAME		"mvebu_serial"
-- 
2.11.0
