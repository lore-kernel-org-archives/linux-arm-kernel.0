From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  6 Jul 2018 10:32:48 +0200
Subject: [PATCH v5 3/4] dt-bindings: display: amlogic: DT fix
 s/resets-names/reset-names/
In-Reply-To: <20180706083249.25399-1-geert+renesas@glider.be>
References: <20180706083249.25399-1-geert+renesas@glider.be>
Message-ID: <20180706083249.25399-4-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes: 8cceda5349377e30 ("dt-bindings: Add bindings for the Amlogic Meson dw-hdmi extension")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
v5:
  - Add Acked-by,

v4:
  - Add Acked-by,

v3:
  - New.
---
 .../devicetree/bindings/display/amlogic,meson-dw-hdmi.txt       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
index bf4a18047309a5f8..d8f6268849f43621 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
@@ -43,7 +43,7 @@ Required properties:
   and the Amlogic Meson venci clocks as described in
   Documentation/devicetree/bindings/clock/clock-bindings.txt,
   the clocks are soc specific, the clock-names should be "iahb", "isfr", "venci"
-- resets, resets-names: must have the phandles to the HDMI apb, glue and phy
+- resets, reset-names: must have the phandles to the HDMI apb, glue and phy
   resets as described in :
   Documentation/devicetree/bindings/reset/reset.txt,
   the reset-names should be "hdmitx_apb", "hdmitx", "hdmitx_phy"
-- 
2.17.1
