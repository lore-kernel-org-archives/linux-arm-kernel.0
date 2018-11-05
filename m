From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 5 Nov 2018 16:43:56 +0800
Subject: [PATCH 2/2] dt-bindings: arm: mediatek: document clk bindings for
 MT7629
In-Reply-To: <815e38d4d74689980cd73c86d9e80fd5854cfc94.1541143168.git.ryder.lee@mediatek.com>
References: <815e38d4d74689980cd73c86d9e80fd5854cfc94.1541143168.git.ryder.lee@mediatek.com>
Message-ID: <b947cd11a6b13a7a160bbb6af42261bf50bffe28.1541143168.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the binding documentation for apmixedsys, infracfg,
pciesys, pericfg, topckgen, ethsys, sgmiisys and ssusbsys for MT7629.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt     | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt   | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt    | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt    | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt   | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt   | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt   | 1 +
 8 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index 4e4a3c0..de40754 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6797-apmixedsys"
 	- "mediatek,mt7622-apmixedsys"
 	- "mediatek,mt7623-apmixedsys", "mediatek,mt2701-apmixedsys"
+	- "mediatek,mt7629-apmixedsys"
 	- "mediatek,mt8135-apmixedsys"
 	- "mediatek,mt8173-apmixedsys"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
index f17cfe6..6b7e806 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
@@ -9,6 +9,7 @@ Required Properties:
 	- "mediatek,mt2701-ethsys", "syscon"
 	- "mediatek,mt7622-ethsys", "syscon"
 	- "mediatek,mt7623-ethsys", "mediatek,mt2701-ethsys", "syscon"
+	- "mediatek,mt7629-ethsys", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index 89f4272..417bd83 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -12,6 +12,7 @@ Required Properties:
 	- "mediatek,mt6797-infracfg", "syscon"
 	- "mediatek,mt7622-infracfg", "syscon"
 	- "mediatek,mt7623-infracfg", "mediatek,mt2701-infracfg", "syscon"
+	- "mediatek,mt7629-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
index 7fe5dc6..d179a61 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be:
 	- "mediatek,mt7622-pciesys", "syscon"
+	- "mediatek,mt7629-pciesys", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
index 6755514..4c7e478 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt2712-pericfg", "syscon"
 	- "mediatek,mt7622-pericfg", "syscon"
 	- "mediatek,mt7623-pericfg", "mediatek,mt2701-pericfg", "syscon"
+	- "mediatek,mt7629-pericfg", "syscon"
 	- "mediatek,mt8135-pericfg", "syscon"
 	- "mediatek,mt8173-pericfg", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
index d113b8e..30cb645 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be:
 	- "mediatek,mt7622-sgmiisys", "syscon"
+	- "mediatek,mt7629-sgmiisys", "syscon"
 - #clock-cells: Must be 1
 
 The SGMIISYS controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
index b8184da..7cb02c93 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be:
 	- "mediatek,mt7622-ssusbsys", "syscon"
+	- "mediatek,mt7629-ssusbsys", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index d849465..d160c2b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6797-topckgen"
 	- "mediatek,mt7622-topckgen"
 	- "mediatek,mt7623-topckgen", "mediatek,mt2701-topckgen"
+	- "mediatek,mt7629-topckgen"
 	- "mediatek,mt8135-topckgen"
 	- "mediatek,mt8173-topckgen"
 - #clock-cells: Must be 1
-- 
1.9.1
