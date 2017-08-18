From: klaus.goger@theobroma-systems.com (Klaus Goger)
Date: Fri, 18 Aug 2017 21:34:43 +0200
Subject: [PATCH v2 3/5] dt-bindings: add rk3399-q7 SoM
In-Reply-To: <20170818193445.47542-1-klaus.goger@theobroma-systems.com>
References: <20170818193445.47542-1-klaus.goger@theobroma-systems.com>
Message-ID: <20170818193445.47542-4-klaus.goger@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK3399-Q7 is a Qseven compatible system-on-module by Theobroma Systems.

This adds the module and the EVK baseboard "Haikou"

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 88d95323d301..c343fb5f6d7b 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -177,6 +177,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "rockchip,rk3399-sapphire-excavator", "rockchip,rk3399";
 
+- Theobroma Systems RK3399-Q7 Haikou Baseboard:
+    Required root node properties:
+      - compatible = "tsd,rk3399-q7-haikou", "rockchip,rk3399";
+
 - Tronsmart Orion R68 Meta
     Required root node properties:
       - compatible = "tronsmart,orion-r68-meta", "rockchip,rk3368";
-- 
2.11.0
