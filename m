From: w.egorov@phytec.de (Wadim Egorov)
Date: Thu, 6 Apr 2017 15:04:26 +0200
Subject: [PATCH v2 3/3] dt-bindings: Document Phytec phyCORE-RK3288 RDK
In-Reply-To: <1491483866-18368-1-git-send-email-w.egorov@phytec.de>
References: <1491483866-18368-1-git-send-email-w.egorov@phytec.de>
Message-ID: <1491483866-18368-3-git-send-email-w.egorov@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for the PCM-947 carrier board, a RK3288 based
development board made by PHYTEC.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
No changes in v2
---
 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index cc4ace6..e079a62 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -103,6 +103,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "mqmaker,miqi", "rockchip,rk3288";
 
+- Phytec phyCORE-RK3288: Rapid Development Kit
+    Required root node properties:
+     - compatible = "phytec,rk3288-pcm-947", "phytec,rk3288-phycore-som", "rockchip,rk3288";
+
 - Rockchip PX3 Evaluation board:
     Required root node properties:
       - compatible = "rockchip,px3-evb", "rockchip,px3", "rockchip,rk3188";
-- 
1.9.1
