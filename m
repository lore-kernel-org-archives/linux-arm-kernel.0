From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed,  2 Aug 2017 16:52:33 +0800
Subject: [PATCH v2 19/23] dt-bindings: adc: add description for rv1108 saradc
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1501663953-12768-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree bindings document for saradc on
rockchip rv1108 soc.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
index e0a9b9d..c2c50b5 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
@@ -6,6 +6,7 @@ Required properties:
    - "rockchip,rk3066-tsadc": for rk3036
    - "rockchip,rk3328-saradc", "rockchip,rk3399-saradc": for rk3328
    - "rockchip,rk3399-saradc": for rk3399
+   - "rockchip,rv1108-saradc", "rockchip,rk3399-saradc": for rv1108
 
 - reg: physical base address of the controller and length of memory mapped
        region.
-- 
2.7.4
