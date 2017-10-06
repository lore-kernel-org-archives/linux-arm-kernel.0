From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Fri,  6 Oct 2017 12:13:39 +0200
Subject: [PATCH 11/16] serial: mvebu-uart: augment the maximum number of ports
In-Reply-To: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
Message-ID: <20171006101344.15590-12-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A3700 boards may have up to two UART ports. Set the new limit to two
maximum UART ports.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 drivers/tty/serial/mvebu-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index b52cbe8c0558..3e46affa09a8 100644
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
