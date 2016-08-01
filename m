From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon,  1 Aug 2016 23:13:50 +0800
Subject: [PATCH v3 1/2] Documentation: dt: Add new compatible to sunxi mmc
 driver bindings
In-Reply-To: <20160801151351.51854-1-icenowy@aosc.xyz>
References: <20160801151351.51854-1-icenowy@aosc.xyz>
Message-ID: <20160801151351.51854-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v2:
- Rebased on Hans de Goede's patchset.

 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
index 904ff9f..55cdd80 100644
--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
@@ -13,6 +13,7 @@ Required properties:
    * "allwinner,sun5i-a13-mmc"
    * "allwinner,sun7i-a20-mmc"
    * "allwinner,sun9i-a80-mmc"
+   * "allwinner,sun50i-a64-mmc"
  - reg : mmc controller base registers
  - clocks : a list with 4 phandle + clock specifier pairs
  - clock-names : must contain "ahb", "mmc", "output" and "sample"
-- 
2.9.0
