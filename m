From: vigneshr@ti.com (Vignesh R)
Date: Wed, 7 Nov 2018 16:09:25 +0530
Subject: [PATCH 1/2] dt-bindings: spi: omap-spi: Add compatible for AM654 SoC
In-Reply-To: <20181107103926.32550-1-vigneshr@ti.com>
References: <20181107103926.32550-1-vigneshr@ti.com>
Message-ID: <20181107103926.32550-2-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM654 SoC has same McSPI IP as OMAP2+ platforms. Add new compatible to
support McSPI on AM654 SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/spi/omap-spi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
index 2ba5f9c023ac..487208c256c0 100644
--- a/Documentation/devicetree/bindings/spi/omap-spi.txt
+++ b/Documentation/devicetree/bindings/spi/omap-spi.txt
@@ -2,6 +2,7 @@ OMAP2+ McSPI device
 
 Required properties:
 - compatible :
+  - "ti,am654-mcspi" for AM654.
   - "ti,omap2-mcspi" for OMAP2 & OMAP3.
   - "ti,omap4-mcspi" for OMAP4+.
 - ti,spi-num-cs : Number of chipselect supported  by the instance.
-- 
2.19.1
