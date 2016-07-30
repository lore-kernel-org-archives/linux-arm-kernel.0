From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 30 Jul 2016 17:36:51 +0800
Subject: [PATCH 1/2] Documentation: dt: Add new compatible to sunxi mmc driver
 bindings
Message-ID: <20160730093652.10578-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
index 4bf41d8..ecd30ac 100644
--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
@@ -8,7 +8,8 @@ as the speed of SD standard 3.0.
 Absolute maximum transfer rate is 200MB/s
 
 Required properties:
- - compatible : "allwinner,sun4i-a10-mmc" or "allwinner,sun5i-a13-mmc"
+ - compatible : "allwinner,sun4i-a10-mmc" , "allwinner,sun5i-a13-mmc",
+		"allwinner,sun9i-a80-mmc" or "allwinner,sun50i-a64-mmc"
  - reg : mmc controller base registers
  - clocks : a list with 4 phandle + clock specifier pairs
  - clock-names : must contain "ahb", "mmc", "output" and "sample"
-- 
2.9.0
