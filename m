From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 06 Oct 2012 13:47:08 +0100
Subject: [RFC 24/24] SERIAL: omap: remove OMAP_UART_SYSC_RESET and
 OMAP_UART_FIFO_CLR
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Message-ID: <E1TKTme-0002nz-5E@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP_UART_SYSC_RESET and OMAP_UART_FIFO_CLR are unused, remove them.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index bad00f1..da2e51f 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -32,9 +32,6 @@
  */
 #define OMAP_SERIAL_NAME	"ttyO"
 
-#define OMAP_UART_SYSC_RESET	0X07
-#define OMAP_UART_FIFO_CLR	0X06
-
 struct omap_uart_port_info {
 	bool			dma_enabled;	/* To specify DMA Mode */
 	unsigned int		uartclk;	/* UART clock rate */
-- 
1.7.4.4
