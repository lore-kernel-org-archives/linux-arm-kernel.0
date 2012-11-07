From: hechtb@gmail.com (Bastian Hecht)
Date: Wed,  7 Nov 2012 12:40:07 +0100
Subject: [PATCH 4/4] devicetree: Add Renesas SH Mobile MSIOF spi controller
 binding doc
In-Reply-To: <1352288407-20594-1-git-send-email-hechtb@gmail.com>
References: <1352288407-20594-1-git-send-email-hechtb@gmail.com>
Message-ID: <1352288407-20594-5-git-send-email-hechtb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for Renesas' MSIOF SPI controller.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/sh-msiof.txt

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
new file mode 100644
index 0000000..b62312e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -0,0 +1,12 @@
+Renesas MSIOF spi controller
+
+Required properties:
+- compatible : 	"renesas,sh-msiof" for SuperH or
+		"renesas,sh-mobile-msiof" for SH Mobile series
+- reg : Offset and length of the register set for the device
+- interrupts : interrupt line used by MSIOF
+
+Optional properties:
+- chip_select  : Chip select, defaults to 0
+- tx_fifo_size : Overrides the default tx fifo size given in words
+- rx_fifo_size : Overrides the default rx fifo size given in words
-- 
1.7.5.4
