From: weiqing.kong@mediatek.com (Weiqing Kong)
Date: Mon, 11 Jul 2016 16:18:07 +0800
Subject: [PATCH V2 1/3] dt-bindings: pwm: Add MediaTek display PWM bindings
In-Reply-To: <1468225089-28576-1-git-send-email-weiqing.kong@mediatek.com>
References: <1468225089-28576-1-git-send-email-weiqing.kong@mediatek.com>
Message-ID: <1468225089-28576-2-git-send-email-weiqing.kong@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MT2701 compatible string.

Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
---
 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
index f8f59ba..6f8af2b 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
@@ -2,8 +2,9 @@ MediaTek display PWM controller
 
 Required properties:
  - compatible: should be "mediatek,<name>-disp-pwm":
-   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
+   - "mediatek,mt2701-disp-pwm": found on mt2701 SoC.
    - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
+   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
    the cell format.
-- 
1.8.1.1.dirty
