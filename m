From: frank.wang@rock-chips.com (Frank Wang)
Date: Mon, 21 Aug 2017 16:39:26 +0800
Subject: [PATCH 1/3] dt-bindings: update dt-binding for rv1108 SoCs
In-Reply-To: <1503304768-14520-1-git-send-email-frank.wang@rock-chips.com>
References: <1503304768-14520-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1503304768-14520-2-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the compatible of GRF and USBGRF for RV1108 SoCs.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.txt b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
index cc9f05d..7dc5ce8 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
@@ -21,6 +21,7 @@ Required Properties:
    - "rockchip,rk3328-grf", "syscon": for rk3328
    - "rockchip,rk3368-grf", "syscon": for rk3368
    - "rockchip,rk3399-grf", "syscon": for rk3399
+   - "rockchip,rv1108-grf", "syscon": for rv1108
 - compatible: PMUGRF should be one of the following:
    - "rockchip,rk3368-pmugrf", "syscon": for rk3368
    - "rockchip,rk3399-pmugrf", "syscon": for rk3399
@@ -28,6 +29,8 @@ Required Properties:
    - "rockchip,rk3288-sgrf", "syscon": for rk3288
 - compatible: USB2PHYGRF should be one of the followings
    - "rockchip,rk3328-usb2phy-grf", "syscon": for rk3328
+- compatible: USBGRF should be one of the following
+   - "rockchip,rv1108-usbgrf", "syscon": for rv1108
 - reg: physical base address of the controller and length of memory mapped
   region.
 
-- 
2.0.0
