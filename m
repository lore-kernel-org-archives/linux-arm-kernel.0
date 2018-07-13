From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 13 Jul 2018 17:24:57 +0800
Subject: [PATCH 2/3] dt-bindings: arm: syna: add support for the AS370 SoC
In-Reply-To: <20180713171712.05f58a74@xhacker.debian>
References: <20180713171712.05f58a74@xhacker.debian>
Message-ID: <20180713172457.6193a92f@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AS370 SoC is a new derivative of the berlin family. The only
difference is the SoC isn't named as berlin*.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/arm/syna.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/syna.txt b/Documentation/devicetree/bindings/arm/syna.txt
index 3bab18409b7a..3ba1d7b5ee74 100644
--- a/Documentation/devicetree/bindings/arm/syna.txt
+++ b/Documentation/devicetree/bindings/arm/syna.txt
@@ -1,4 +1,4 @@
-Marvell Berlin SoC Family Device Tree Bindings
+Synaptics SoC Device Tree Bindings
 ---------------------------------------------------------------
 
 Work in progress statement:
@@ -13,6 +13,10 @@ stable binding/ABI.
 
 ---------------------------------------------------------------
 
+Boards with the Synaptics AS370 SoC shall have the following properties:
+  Required root node property:
+    compatible: "syna,as370"
+
 Boards with a SoC of the Marvell Berlin family, e.g. Armada 1500
 shall have the following properties:
 
-- 
2.18.0
