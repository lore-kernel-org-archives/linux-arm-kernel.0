From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 25 Aug 2014 08:23:42 +0200
Subject: [PATCH v5 1/7] DT doc: net: cpsw mac-address is optional
In-Reply-To: <1408947828-22316-1-git-send-email-mpa@pengutronix.de>
References: <1408947828-22316-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1408947828-22316-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mac-address is an optional property. If no mac-address is set, a random
mac-address will be generated.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/devicetree/bindings/net/cpsw.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
index ae2b8b7f9c38..107caf174a0e 100644
--- a/Documentation/devicetree/bindings/net/cpsw.txt
+++ b/Documentation/devicetree/bindings/net/cpsw.txt
@@ -29,10 +29,10 @@ Slave Properties:
 Required properties:
 - phy_id		: Specifies slave phy id
 - phy-mode		: See ethernet.txt file in the same directory
-- mac-address		: See ethernet.txt file in the same directory
 
 Optional properties:
 - dual_emac_res_vlan	: Specifies VID to be used to segregate the ports
+- mac-address		: See ethernet.txt file in the same directory
 
 Note: "ti,hwmods" field is used to fetch the base address and irq
 resources from TI, omap hwmod data base during device registration.
-- 
2.1.0.rc1
