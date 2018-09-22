From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 22 Sep 2018 17:10:00 +0200
Subject: [PATCH v2 2/5] dt-bindings: arm: amlogic: Add the Endless Mobile
 Endless Mini (EC-100)
In-Reply-To: <20180922151003.4736-1-martin.blumenstingl@googlemail.com>
References: <20180922151003.4736-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180922151003.4736-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings documentation for the Endless Mini (EC-100) from Endless
Mobile.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index b5c2b5c35766..2c2eee206736 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -63,6 +63,7 @@ Board compatible values (alphabetically, grouped by SoC):
 
   - "minix,neo-x8" (Meson8)
 
+  - "endless,ec100" (Meson8b)
   - "hardkernel,odroid-c1" (Meson8b)
   - "tronfy,mxq" (Meson8b)
 
-- 
2.19.0
