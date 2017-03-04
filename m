From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  4 Mar 2017 22:51:25 +0100
Subject: [PATCH 2/3] dt-bindings: amlogic: add the Khadas VIM
In-Reply-To: <20170304215126.7020-1-martin.blumenstingl@googlemail.com>
References: <20170304215126.7020-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170304215126.7020-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index c246cd2730d9..354b76da95fa 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -43,6 +43,8 @@ Board compatible values:
   - "wetek,hub" (Meson gxbb)
   - "wetek,play2" (Meson gxbb)
   - "amlogic,p212" (Meson gxl s905x)
+  - "khadas,vim" (Meson gxl s905x)
+
   - "amlogic,p230" (Meson gxl s905d)
   - "amlogic,p231" (Meson gxl s905d)
   - "amlogic,q200" (Meson gxm s912)
-- 
2.12.0
