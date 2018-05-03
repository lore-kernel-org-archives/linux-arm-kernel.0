From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 3 May 2018 21:26:21 +0800
Subject: [PATCH v8 2/5] dt-bindings: clock: axg-aoclkc: New binding for
 Meson-AXG SoC
In-Reply-To: <20180503132624.78453-1-yixun.lan@amlogic.com>
References: <20180503132624.78453-1-yixun.lan@amlogic.com>
Message-ID: <20180503132624.78453-3-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the dt-binding documentation to support new compatible string
for the Amlogic's Meson-AXG SoC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
index 786dc39ca904..3a880528030e 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
@@ -9,6 +9,7 @@ Required Properties:
 	- GXBB (S905) : "amlogic,meson-gxbb-aoclkc"
 	- GXL (S905X, S905D) : "amlogic,meson-gxl-aoclkc"
 	- GXM (S912) : "amlogic,meson-gxm-aoclkc"
+	- AXG (A113D, A113X) : "amlogic,meson-axg-aoclkc"
 	followed by the common "amlogic,meson-gx-aoclkc"
 
 - #clock-cells: should be 1.
-- 
2.17.0
