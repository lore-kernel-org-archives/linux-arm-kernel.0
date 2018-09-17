From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Mon, 17 Sep 2018 16:02:11 +0800
Subject: [PATCH v2 2/3] dt-bindings: arm: syna: add support for the AS370 SoC
In-Reply-To: <20180917160015.05a1fc5b@xhacker.debian>
References: <20180917160015.05a1fc5b@xhacker.debian>
Message-ID: <20180917160211.7b1cd37d@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AS370 SoC is a new derivative of the berlin family. However, the
SoC isn't named as berlin*.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/arm/syna.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/syna.txt b/Documentation/devicetree/bindings/arm/syna.txt
index 3bab18409b7a..2face46a5f64 100644
--- a/Documentation/devicetree/bindings/arm/syna.txt
+++ b/Documentation/devicetree/bindings/arm/syna.txt
@@ -1,4 +1,9 @@
-Marvell Berlin SoC Family Device Tree Bindings
+Synaptics SoC Device Tree Bindings
+
+According to https://www.synaptics.com/company/news/conexant-marvell
+Synaptics has acquired the Multimedia Solutions Business of Marvell, so
+berlin SoCs are now Synaptics' SoCs now.
+
 ---------------------------------------------------------------
 
 Work in progress statement:
@@ -13,6 +18,10 @@ stable binding/ABI.
 
 ---------------------------------------------------------------
 
+Boards with the Synaptics AS370 SoC shall have the following properties:
+  Required root node property:
+    compatible: "syna,as370"
+
 Boards with a SoC of the Marvell Berlin family, e.g. Armada 1500
 shall have the following properties:
 
-- 
2.19.0
