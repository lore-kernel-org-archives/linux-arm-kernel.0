From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed,  2 Aug 2017 16:47:55 +0800
Subject: [PATCH v2 16/23] dt-bindings: pwm: add description for rv1108 pwm
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1501663675-12591-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree bindings document for pwm on
rockchip rv1108 soc.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
index 2350ef9..b49f121 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
@@ -3,7 +3,7 @@ Rockchip PWM controller
 Required properties:
  - compatible: should be "rockchip,<name>-pwm"
    "rockchip,rk2928-pwm": found on RK29XX,RK3066 and RK3188 SoCs
-   "rockchip,rk3288-pwm": found on RK3288 SoC
+   "rockchip,rk3288-pwm": found on RK3288 and RV1108 SoCs
    "rockchip,vop-pwm": found integrated in VOP on RK3288 SoC
  - reg: physical base address and length of the controller's registers
  - clocks: See ../clock/clock-bindings.txt
-- 
2.7.4
