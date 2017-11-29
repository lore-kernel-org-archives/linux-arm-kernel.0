From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 29 Nov 2017 12:18:41 -0800
Subject: [PATCH 1/9] dt-bindings: arm: Add entry for Broadcom Brahma-B53
In-Reply-To: <20171129201849.17522-1-f.fainelli@gmail.com>
References: <20171129201849.17522-1-f.fainelli@gmail.com>
Message-ID: <20171129201849.17522-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Broadcom's Brahma-B53 CPU is an ARMv8A processor used on a number of
DSL, Cable Modem and Set-top-box SoCs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index a0009b72e9be..f4a777039f03 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -169,6 +169,7 @@ described below.
 			    "arm,cortex-r5"
 			    "arm,cortex-r7"
 			    "brcm,brahma-b15"
+			    "brcm,brahma-b53"
 			    "brcm,vulcan"
 			    "cavium,thunder"
 			    "cavium,thunder2"
-- 
2.9.3
