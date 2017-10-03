From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  3 Oct 2017 17:29:45 +0200
Subject: [PATCH v2 2/2] dt-bindings: arm: amlogic: Add Tronsmart Vega S96
 binding
In-Reply-To: <1507044585-20117-1-git-send-email-narmstrong@baylibre.com>
References: <1507044585-20117-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1507044585-20117-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: support at tronsmart.com
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Oleg Ivanov <balbes-150@yandex.ru>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 4e4bc0b..d6163ac 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -73,6 +73,7 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amlogic,q201" (Meson gxm s912)
   - "kingnovel,r-box-pro" (Meson gxm S912)
   - "nexbox,a1" (Meson gxm s912)
+  - "tronsmart,vega-s96" (Meson gxm s912)
 
 Amlogic Meson Firmware registers Interface
 ------------------------------------------
-- 
2.7.4
