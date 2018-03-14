From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 14 Mar 2018 15:53:11 +0200
Subject: [PATCH v2 2/6] dt-bindings: omap5: ctrl: Support for control module
 wkup pad config
In-Reply-To: <20180314135315.11215-1-peter.ujfalusi@ti.com>
References: <20180314135315.11215-1-peter.ujfalusi@ti.com>
Message-ID: <20180314135315.11215-3-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <t-kristo@ti.com>

The pad configuration area under control module wkup has some miscellaneous
config registers, that are not pinmux related.
Add new compatible string for this section of control module.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/ctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
index ce8dabf8c0f9..f35b77920786 100644
--- a/Documentation/devicetree/bindings/arm/omap/ctrl.txt
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -25,6 +25,7 @@ Required properties:
 		"ti,omap4-scm-padconf-wkup"
 		"ti,omap5-scm-core"
 		"ti,omap5-scm-padconf-core"
+		"ti,omap5-scm-wkup-pad-conf"
 		"ti,dra7-scm-core"
 - reg:		Contains Control Module register address range
 		(base address and length)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
