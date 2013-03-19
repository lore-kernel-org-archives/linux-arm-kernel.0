From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Mar 2013 19:00:53 +0530
Subject: [PATCH v2 07/11] Documentation: dt: OMAP: l3-noc: Add *reg* in
 required properties
In-Reply-To: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1363699857-5505-8-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP L3 driver needs reg address space for its operation and
hence its a required property.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 .../devicetree/bindings/arm/omap/l3-noc.txt        |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
index 6888a5e..c0105de 100644
--- a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
+++ b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
@@ -6,6 +6,7 @@ provided by Arteris.
 Required properties:
 - compatible : Should be "ti,omap3-l3-smx" for OMAP3 family
                Should be "ti,omap4-l3-noc" for OMAP4 family
+- reg:	Contains L3 register address range for each noc domain.
 - ti,hwmods: "l3_main_1", ... One hwmod for each noc domain.
 
 Examples:
-- 
1.7.9.5
