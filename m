From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 26 Apr 2018 16:05:07 +0000
Subject: [PATCH 1/2] dt-bindings: net: meson-dwmac: new compatible name for
 AXG SoC
In-Reply-To: <20180426160508.29380-1-yixun.lan@amlogic.com>
References: <20180426160508.29380-1-yixun.lan@amlogic.com>
Message-ID: <20180426160508.29380-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to introduce a new compatible name for the Meson-AXG SoC
in order to support the RMII 100M ethernet PHY, since the PRG_ETH0
register of the dwmac glue layer is changed from previous old SoC.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/net/meson-dwmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/meson-dwmac.txt b/Documentation/devicetree/bindings/net/meson-dwmac.txt
index 61cada22ae6c..1321bb194ed9 100644
--- a/Documentation/devicetree/bindings/net/meson-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/meson-dwmac.txt
@@ -11,6 +11,7 @@ Required properties on all platforms:
 			- "amlogic,meson8b-dwmac"
 			- "amlogic,meson8m2-dwmac"
 			- "amlogic,meson-gxbb-dwmac"
+			- "amlogic,meson-axg-dwmac"
 		Additionally "snps,dwmac" and any applicable more
 		detailed version number described in net/stmmac.txt
 		should be used.
-- 
2.17.0
