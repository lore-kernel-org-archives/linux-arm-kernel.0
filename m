From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed,  7 Sep 2016 17:13:41 +0200
Subject: [PATCH 5/7] dt-bindings: spi-meson: Add GXBB Compatible string
In-Reply-To: <1473261223-15412-1-git-send-email-jbrunet@baylibre.com>
References: <1473261223-15412-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1473261223-15412-6-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Armstrong <narmstrong@baylibre.com>

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/spi/spi-meson.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-meson.txt b/Documentation/devicetree/bindings/spi/spi-meson.txt
index bb52a86..dc6d031 100644
--- a/Documentation/devicetree/bindings/spi/spi-meson.txt
+++ b/Documentation/devicetree/bindings/spi/spi-meson.txt
@@ -7,7 +7,7 @@ NOR memories, without DMA support and a 64-byte unified transmit /
 receive buffer.
 
 Required properties:
- - compatible: should be "amlogic,meson6-spifc"
+ - compatible: should be "amlogic,meson6-spifc" or "amlogic,meson-gxbb-spifc"
  - reg: physical base address and length of the controller registers
  - clocks: phandle of the input clock for the baud rate generator
  - #address-cells: should be 1
-- 
2.7.4
