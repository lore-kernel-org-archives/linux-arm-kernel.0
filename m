From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Thu, 28 Sep 2017 03:49:28 +0200
Subject: [PATCH v4 11/11] arm: allwinner: Correct unit name in devicetree
 binding example
In-Reply-To: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
References: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
Message-ID: <5b7a8fb3-21bb-417c-9471-1330dd379fd9@rwthex-w2-a.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unit-names must not start with a leading 0.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>

---

Changes in v4:
- Split minor fix in devicetree example from patch 6/10

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/dma/sun6i-dma.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
index 9700b1d00fed..b2df4f0f1488 100644
--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
@@ -18,7 +18,7 @@ Required properties:
 - #dma-cells :	Should be 1, a single cell holding a line request number
 
 Example:
-	dma: dma-controller at 01c02000 {
+	dma: dma-controller at 1c02000 {
 		compatible = "allwinner,sun6i-a31-dma";
 		reg = <0x01c02000 0x1000>;
 		interrupts = <0 50 4>;
-- 
2.14.1
