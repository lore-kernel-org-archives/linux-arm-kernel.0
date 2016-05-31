From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 31 May 2016 16:19:32 +0200
Subject: [RFT PATCH 2/2] serial: pnx8xxx: Fix coding style
In-Reply-To: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
References: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1464704372-17668-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Definition of function should start from new line.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/tty/serial/pnx8xxx_uart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pnx8xxx_uart.c b/drivers/tty/serial/pnx8xxx_uart.c
index 84c4efdde8dc..9eaedd6a049e 100644
--- a/drivers/tty/serial/pnx8xxx_uart.c
+++ b/drivers/tty/serial/pnx8xxx_uart.c
@@ -690,7 +690,8 @@ static void pnx8xxx_console_putchar(struct uart_port *port, int ch)
 
 /*
  * Interrupts are disabled on entering
- */static void
+ */
+static void
 pnx8xxx_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct pnx8xxx_port *sport = &pnx8xxx_ports[co->index];
-- 
1.9.1
