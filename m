From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 25 Jun 2017 19:00:18 +0200
Subject: [PATCH 3/5] dt-bindings: arm: Document Socionext MB86S71 and Fujitsu
 F-Cue
In-Reply-To: <20170625170020.11791-1-afaerber@suse.de>
References: <20170625170020.11791-1-afaerber@suse.de>
Message-ID: <20170625170020.11791-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For consistency with existing SoC bindings, use "fujitsu,mb86s71" but
socionext.txt.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/socionext.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext.txt

diff --git a/Documentation/devicetree/bindings/arm/socionext.txt b/Documentation/devicetree/bindings/arm/socionext.txt
new file mode 100644
index 000000000000..63227fe7b773
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/socionext.txt
@@ -0,0 +1,17 @@
+Socionext platforms device tree bindings
+----------------------------------------
+
+
+MB86S7x SoC
+===========
+
+Required root node properties:
+
+ - compatible :  must contain "fujitsu,mb86s71" for MB86S71
+
+
+Boards:
+
+Root node property compatible must contain, depending on board:
+
+ - Fujitsu F-Cue: "fujitsu,f-cue"
-- 
2.12.3
