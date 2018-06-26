From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 26 Jun 2018 09:50:10 +0200
Subject: [PATCH 2/2] dt-bindings: arm: scu: Correct example SCU unit addresses
In-Reply-To: <20180626075010.15611-1-geert+renesas@glider.be>
References: <20180626075010.15611-1-geert+renesas@glider.be>
Message-ID: <20180626075010.15611-3-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The unit addresses of the Cortex-A9 SCU device nodes contain too many
zeroes.  Remove them.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/scu.txt          | 2 +-
 Documentation/devicetree/bindings/arm/ux500/boards.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/scu.txt b/Documentation/devicetree/bindings/arm/scu.txt
index 08a587875996b47c..74d0a780ce511998 100644
--- a/Documentation/devicetree/bindings/arm/scu.txt
+++ b/Documentation/devicetree/bindings/arm/scu.txt
@@ -22,7 +22,7 @@ References:
 
 Example:
 
-scu at a04100000 {
+scu at a0410000 {
 	compatible = "arm,cortex-a9-scu";
 	reg = <0xa0410000 0x100>;
 };
diff --git a/Documentation/devicetree/bindings/arm/ux500/boards.txt b/Documentation/devicetree/bindings/arm/ux500/boards.txt
index 0fa429534f4910f7..89408de55bfd2a62 100644
--- a/Documentation/devicetree/bindings/arm/ux500/boards.txt
+++ b/Documentation/devicetree/bindings/arm/ux500/boards.txt
@@ -60,7 +60,7 @@ Example:
 			      <0xa0410100 0x100>;
 		};
 
-		scu at a04100000 {
+		scu at a0410000 {
 			compatible = "arm,cortex-a9-scu";
 			reg = <0xa0410000 0x100>;
 		};
-- 
2.17.1
