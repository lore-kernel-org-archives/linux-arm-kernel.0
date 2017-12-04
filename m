From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 4 Dec 2017 14:00:16 +0800
Subject: [PATCH 1/3] dt-bindings: pwm: update bindings for the Meson-AXG
In-Reply-To: <20171204060018.8856-1-yixun.lan@amlogic.com>
References: <20171204060018.8856-1-yixun.lan@amlogic.com>
Message-ID: <20171204060018.8856-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jian Hu <jian.hu@amlogic.com>

Update the doc to explicitly support Meson-AXG

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/pwm/pwm-meson.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
index 1ee81321c35e..1fa3f7182133 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
@@ -5,6 +5,8 @@ Required properties:
 - compatible: Shall contain "amlogic,meson8b-pwm"
                          or "amlogic,meson-gxbb-pwm"
                          or "amlogic,meson-gxbb-ao-pwm"
+                         or "amlogic,meson-axg-ee-pwm"
+                         or "amlogic,meson-axg-ao-pwm"
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
   the cells format.
 
-- 
2.15.0
