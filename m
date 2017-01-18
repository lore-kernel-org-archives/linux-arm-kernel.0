From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 18 Jan 2017 11:50:42 +0100
Subject: [PATCH 3/3] dt-bindings: amlogic: Add WeTek boards
In-Reply-To: <1484736642-5451-1-git-send-email-narmstrong@baylibre.com>
References: <1484736642-5451-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1484736642-5451-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 9b2b41a..c246cd2 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -40,6 +40,8 @@ Board compatible values:
   - "hardkernel,odroid-c2" (Meson gxbb)
   - "amlogic,p200" (Meson gxbb)
   - "amlogic,p201" (Meson gxbb)
+  - "wetek,hub" (Meson gxbb)
+  - "wetek,play2" (Meson gxbb)
   - "amlogic,p212" (Meson gxl s905x)
   - "amlogic,p230" (Meson gxl s905d)
   - "amlogic,p231" (Meson gxl s905d)
-- 
1.9.1
