From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 15 Sep 2017 11:18:07 +0200
Subject: [PATCH v2 3/8] dt-bindings: gpu: mali-utgard: add optional
 power-domain reference
In-Reply-To: <20170915091812.13368-1-heiko@sntech.de>
References: <20170915091812.13368-1-heiko@sntech.de>
Message-ID: <20170915091812.13368-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some socs Mali Utgard gpu have both soc power-domains and external
supplying regulators, so add an optional power-domains property for
reference.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 25ebf4140e69..c6814d7cc2b2 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -52,6 +52,10 @@ Optional properties:
     Operating Points for the GPU, as defined in
     Documentation/devicetree/bindings/opp/opp.txt
 
+  - power-domains:
+    A power domain consumer specifier as defined in
+    Documentation/devicetree/bindings/power/power_domain.txt
+
 Vendor-specific bindings
 ------------------------
 
-- 
2.14.1
