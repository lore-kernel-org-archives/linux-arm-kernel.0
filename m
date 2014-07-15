From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 16 Jul 2014 00:59:33 +0200
Subject: [PATCH 1/6] dt-bindings: arm: add arm,
 cortex-a12 cpu compatible property
In-Reply-To: <1471578.ILeMmG2DL6@diego>
References: <1471578.ILeMmG2DL6@diego>
Message-ID: <2686681.eHDb2kq8iP@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is necessary for the new RK3288 soc.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 1fe72a0..620a1a8 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -152,6 +152,7 @@ nodes to be present and contain the properties described below.
 			    "arm,cortex-a7"
 			    "arm,cortex-a8"
 			    "arm,cortex-a9"
+			    "arm,cortex-a12"
 			    "arm,cortex-a15"
 			    "arm,cortex-a53"
 			    "arm,cortex-a57"
-- 
1.9.0
