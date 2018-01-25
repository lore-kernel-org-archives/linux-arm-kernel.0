From: yogeshnarayan.gaur@nxp.com (Yogesh Gaur)
Date: Thu, 25 Jan 2018 12:51:56 +0530
Subject: [PATCH 1/2] Documentation: binding: Update fsl-quadspi binding
In-Reply-To: <1516864917-31969-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1516864917-31969-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <1516864917-31969-2-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

QuadSPI controller supports Single, dual, quad modes of operation.
Mode is controlled via either RCW or the on-board connection to flash.

spi-tx-bus-width, spi-rx-bus-width binding added to define mode
of operation. Definition of these binding are standard as defined
in Documentation/devicetree/bindings/spi/spi-bus.txt.

Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 Documentation/devicetree/bindings/mtd/fsl-quadspi.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
index c34aa6f..13a903e 100644
--- a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
@@ -23,6 +23,10 @@ Optional properties:
 			      bus, you should enable this property.
 			      (Please check the board's schematic.)
   - big-endian : That means the IP register is big endian
+  - spi-tx-bus-width - Definition as per
+                     Documentation/devicetree/bindings/spi/spi-bus.txt
+  - spi-rx-bus-width - Definition as per
+                     Documentation/devicetree/bindings/spi/spi-bus.txt
 
 Example:
 
-- 
1.9.1
