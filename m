From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 13 Nov 2018 11:22:23 +0100
Subject: [PATCH v3 1/6] spi: pxa2xx: dt-bindings: Add spi-slave property
In-Reply-To: <20181113102228.820214-1-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
Message-ID: <20181113102228.820214-2-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used to indicate that the chip attached to this controller is a SPI
master.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2:
- Updated the subject line to conform with subsystem customs

 Documentation/devicetree/bindings/spi/spi-pxa2xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
index 0335a9bd2e8a..89b2832283e3 100644
--- a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
@@ -11,6 +11,7 @@ Required properties:
 Optional properties:
 - cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
   Documentation/devicetree/bindings/spi/spi-bus.txt
+- spi-slave: Empty property indicating the SPI controller is used in slave mode.
 
 Child nodes represent devices on the SPI bus
   See ../spi/spi-bus.txt
-- 
2.19.1
