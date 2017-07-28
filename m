From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 28 Jul 2017 11:28:16 +0200
Subject: [PATCH 1/3] dt-bindings: net: add compatible for internal
 sun8i-h3/sun8i-v3s PHYs
In-Reply-To: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
References: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
Message-ID: <20170728092818.23419-2-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The internal PHYs for H3 ans V3S now need to have their own compatible.
This patch rename them in the binding documentation.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
index 725f3b187886..851e89052424 100644
--- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
+++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
@@ -49,8 +49,8 @@ The device node referenced by "phy" or "phy-handle" should be a child node
 of the mdio node. See phy.txt for the generic PHY bindings.
 
 Required properties of the phy node with the following compatibles:
-  - "allwinner,sun8i-h3-emac",
-  - "allwinner,sun8i-v3s-emac":
+  - "allwinner,sun8i-h3-ephy",
+  - "allwinner,sun8i-v3s-ephy":
 - clocks: a phandle to the reference clock for the EPHY
 - resets: a phandle to the reset control for the EPHY
 
-- 
2.13.0
