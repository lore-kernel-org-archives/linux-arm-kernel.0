From: codekipper@gmail.com (codekipper at gmail.com)
Date: Thu, 12 Jan 2017 18:33:43 +0100
Subject: [PATCH] ASoC: sunxi: Add bindings for sun8i to SPDIF
Message-ID: <20170112173343.9953-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The H3 SoC uses the same SPDIF block as found in earlier SoCs, but the
transmit fifo is at a different address.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
index 0230c4d20506..fe0a65e6d629 100644
--- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
@@ -10,6 +10,7 @@ Required properties:
   - compatible		: should be one of the following:
     - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
     - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
+    - "allwinner,sun8i-h3-spdif": for the Allwinner H3 SoC
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.11.0
