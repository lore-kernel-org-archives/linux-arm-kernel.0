From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:21:44 +0100
Subject: [PATCH 2/2] arm64: renesas: document V3MSK board bindings
In-Reply-To: <cover.1512553735.git.horms+renesas@verge.net.au>
References: <cover.1512553735.git.horms+renesas@verge.net.au>
Message-ID: <eebd0732136fd293c8f15a435978c1c34cd7f32f.1512553735.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Document the V3M Starter Kit device tree bindings, listing it as
a supported board.

This allows to use checkpatch.pl to validate .dts files referring to
the V3MSK board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 062520a0e74c..5c3af7ef0761 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -112,6 +112,8 @@ Boards:
     compatible = "renesas,sk-rzg1e", "renesas,r8a7745"
   - SK-RZG1M (YR8A77430S000BE)
     compatible = "renesas,sk-rzg1m", "renesas,r8a7743"
+  - V3MSK
+    compatible = "renesas,v3msk", "renesas,r8a77970"
   - Wheat
     compatible = "renesas,wheat", "renesas,r8a7792"
 
-- 
2.11.0
