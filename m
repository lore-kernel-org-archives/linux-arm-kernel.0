From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 18 Mar 2017 13:36:56 +0100
Subject: [PATCH v2 2/3] dt-bindings: amlogic: add the Khadas VIM
In-Reply-To: <20170318123657.13798-1-martin.blumenstingl@googlemail.com>
References: <20170304215126.7020-1-martin.blumenstingl@googlemail.com>
 <20170318123657.13798-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170318123657.13798-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index b3241a6802f6..bfd5b558477d 100644
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
   - "hwacom,amazetv" (Meson gxl s905x)
-- 
2.12.0
