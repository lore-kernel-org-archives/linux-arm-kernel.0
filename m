From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 13 Sep 2018 22:22:00 +0200
Subject: [PATCH 2/5] dt-bindings: arm: amlogic: Add the Endless Mobile Endless
 Mini (EC-100)
In-Reply-To: <20180913202203.19636-1-martin.blumenstingl@googlemail.com>
References: <20180913202203.19636-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180913202203.19636-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings documentation for the Endless Mini (EC-100) from Endless
Mobile.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index b5c2b5c35766..99ca80d87aad 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -63,6 +63,7 @@ Board compatible values (alphabetically, grouped by SoC):
 
   - "minix,neo-x8" (Meson8)
 
+  - "endless,ec-100" (Meson8b)
   - "hardkernel,odroid-c1" (Meson8b)
   - "tronfy,mxq" (Meson8b)
 
-- 
2.19.0
