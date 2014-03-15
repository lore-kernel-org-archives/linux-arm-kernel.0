From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 15 Mar 2014 14:07:40 +0100
Subject: [PATCH v2 1/5] net: cpsw: document mac-address being optional
In-Reply-To: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
References: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1394888864-11007-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mac-address is an optional property. If no mac-address is set, a random
mac-address will be generated.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/net/cpsw.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
index 05d660e..c39f077 100644
--- a/Documentation/devicetree/bindings/net/cpsw.txt
+++ b/Documentation/devicetree/bindings/net/cpsw.txt
@@ -30,10 +30,10 @@ Required properties:
 - phy_id		: Specifies slave phy id
 - phy-mode		: The interface between the SoC and the PHY (a string
 			  that of_get_phy_mode() can understand)
-- mac-address		: Specifies slave MAC address
 
 Optional properties:
 - dual_emac_res_vlan	: Specifies VID to be used to segregate the ports
+- mac-address		: Specifies slave MAC address
 
 Note: "ti,hwmods" field is used to fetch the base address and irq
 resources from TI, omap hwmod data base during device registration.
-- 
1.9.0
