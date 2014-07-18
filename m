From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 18 Jul 2014 02:19:21 +0200
Subject: [PATCH v2 1/7] dt-bindings: arm: add cortex-a12 and cortex-a17 cpu
 compatible properties
In-Reply-To: <4868343.UFgjaXesOn@diego>
References: <4868343.UFgjaXesOn@diego>
Message-ID: <1405647289.JhjFpUvHI8@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As announced parts from ARM they will probably be used in socs shortly.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 1fe72a0..bc6dc17 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -152,7 +152,9 @@ nodes to be present and contain the properties described below.
 			    "arm,cortex-a7"
 			    "arm,cortex-a8"
 			    "arm,cortex-a9"
+			    "arm,cortex-a12"
 			    "arm,cortex-a15"
+			    "arm,cortex-a17"
 			    "arm,cortex-a53"
 			    "arm,cortex-a57"
 			    "arm,cortex-m0"
-- 
1.9.0
