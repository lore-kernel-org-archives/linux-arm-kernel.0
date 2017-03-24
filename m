From: cl@rock-chips.com (cl at rock-chips.com)
Date: Fri, 24 Mar 2017 19:01:22 +0800
Subject: [PATCH v3 1/6] dt-bindings: iio: rockchip-saradc: add support for
 rk3328
In-Reply-To: <1490353287-25122-1-git-send-email-cl@rock-chips.com>
References: <1490353287-25122-1-git-send-email-cl@rock-chips.com>
Message-ID: <1490353287-25122-2-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

The rk3328 saradc is the same as rk3399.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
index 205593f..e0a9b9d 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: should be "rockchip,<name>-saradc" or "rockchip,rk3066-tsadc"
    - "rockchip,saradc": for rk3188, rk3288
    - "rockchip,rk3066-tsadc": for rk3036
+   - "rockchip,rk3328-saradc", "rockchip,rk3399-saradc": for rk3328
    - "rockchip,rk3399-saradc": for rk3399
 
 - reg: physical base address of the controller and length of memory mapped
-- 
1.9.1
