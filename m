From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 14 Dec 2017 18:39:39 +0530
Subject: [PATCH 10/12] dt-bindings: sdhci-omap: Add K2G specific binding
In-Reply-To: <20171214130941.26666-1-kishon@ti.com>
References: <20171214130941.26666-1-kishon@ti.com>
Message-ID: <20171214130941.26666-11-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding for the TI's sdhci-omap controller present in K2G.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
index 51775a372c06..8d09b837e350 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
@@ -4,7 +4,9 @@ Refer to mmc.txt for standard MMC bindings.
 
 Required properties:
 - compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
+	      Should be "ti,k2g-sdhci" for K2G
 - ti,hwmods: Must be "mmc<n>", <n> is controller instance starting 1
+	     (Not required for K2G).
 
 Example:
 	mmc1: mmc at 4809c000 {
-- 
2.11.0
