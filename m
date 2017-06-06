From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:17 +0200
Subject: [PATCH v4 19/28] dt-bindings: arm: cpus: Add S500 enable-method
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-20-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Actions Semi S500 SoC requires a special secondary CPU boot procedure.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4: Unchanged
 
 v3: new
 
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 2713aadb7411..ad1913bea8d7 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -193,6 +193,7 @@ nodes to be present and contain the properties described below.
 			     "spin-table"
 			# On ARM 32-bit systems this property is optional and
 			  can be one of:
+			    "actions,s500-smp"
 			    "allwinner,sun6i-a31"
 			    "allwinner,sun8i-a23"
 			    "arm,realview-smp"
-- 
2.12.3
