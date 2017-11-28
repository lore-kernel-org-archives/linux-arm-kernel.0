From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 28 Nov 2017 21:29:24 +0800
Subject: [PATCH 1/3] dt-bindings: spicc: update compatible string for the
 Meson-AXG
In-Reply-To: <20171128132926.19051-1-yixun.lan@amlogic.com>
References: <20171128132926.19051-1-yixun.lan@amlogic.com>
Message-ID: <20171128132926.19051-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunny Luo <sunny.luo@amlogic.com>

Update the compatbile string to support Meson-AXG SoCs.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/spi/spi-meson.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-meson.txt b/Documentation/devicetree/bindings/spi/spi-meson.txt
index 825c39cae74a..b7f5e86fed22 100644
--- a/Documentation/devicetree/bindings/spi/spi-meson.txt
+++ b/Documentation/devicetree/bindings/spi/spi-meson.txt
@@ -27,7 +27,9 @@ The Meson SPICC is generic SPI controller for general purpose Full-Duplex
 communications with dedicated 16 words RX/TX PIO FIFOs.
 
 Required properties:
- - compatible: should be "amlogic,meson-gx-spicc" on Amlogic GX SoCs.
+ - compatible: should be:
+	"amlogic,meson-gx-spicc" on Amlogic GX and compatible SoCs.
+	"amlogic,meson-axg-spicc" on Amlogic AXG and compatible SoCs
  - reg: physical base address and length of the controller registers
  - interrupts: The interrupt specifier
  - clock-names: Must contain "core"
-- 
2.15.0
