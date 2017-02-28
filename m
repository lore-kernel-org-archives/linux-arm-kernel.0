From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 28 Feb 2017 07:35:29 +0100
Subject: [PATCH v3 19/25] dt-bindings: arm: cpus: Add S500 enable-method
In-Reply-To: <20170228063535.32069-1-afaerber@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
Message-ID: <20170228063535.32069-20-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Actions Semi S500 SoC requires a special secondary CPU boot procedure.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3: new
 
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 698ad1f0..e3e1e2f 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -192,6 +192,7 @@ nodes to be present and contain the properties described below.
 			     "spin-table"
 			# On ARM 32-bit systems this property is optional and
 			  can be one of:
+			    "actions,s500-smp"
 			    "allwinner,sun6i-a31"
 			    "allwinner,sun8i-a23"
 			    "arm,realview-smp"
-- 
2.10.2
