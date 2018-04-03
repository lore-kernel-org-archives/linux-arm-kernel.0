From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 3 Apr 2018 18:06:49 +0800
Subject: [PATCH 1/3] mmc: dt-bindings: update bindings doc to support
 Meson-AXG SoC
In-Reply-To: <20180403100652.41056-1-yixun.lan@amlogic.com>
References: <20180403100652.41056-1-yixun.lan@amlogic.com>
Message-ID: <20180403100652.41056-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nan Li <nan.li@amlogic.com>

Update the documentation to list support for Meson-AXG SoC explicitly.
The new binding string is necessary since this SoC introduce a few
IP difference comparing to previous old generation.

Signed-off-by: Nan Li <nan.li@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
index 50bf611a4d2c..5add8d7d855f 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
@@ -12,6 +12,7 @@ Required properties:
   - "amlogic,meson-gxbb-mmc"
   - "amlogic,meson-gxl-mmc"
   - "amlogic,meson-gxm-mmc"
+  - "amlogic,meson-axg-mmc"
 - clocks     : A list of phandle + clock-specifier pairs for the clocks listed in clock-names.
 - clock-names: Should contain the following:
 	"core" - Main peripheral bus clock
-- 
2.16.2
