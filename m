From: william.wu@rock-chips.com (William Wu)
Date: Mon, 21 Aug 2017 21:36:04 +0800
Subject: [PATCH v3 1/3] dt-bindings: usb: add DT binding for RK3328 dwc3
 controller
In-Reply-To: <1503322566-31489-1-git-send-email-william.wu@rock-chips.com>
References: <1503322566-31489-1-git-send-email-william.wu@rock-chips.com>
Message-ID: <1503322566-31489-2-git-send-email-william.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the device tree bindings description for RK3328 and
compatible USB DWC3 controller.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
Changes in v3:
- Add this for separate usb dt-bindings patch.

Changes in v2:
- None

 Documentation/devicetree/bindings/usb/rockchip,dwc3.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
index 0536a93..d6b2e47 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
@@ -1,7 +1,9 @@
 Rockchip SuperSpeed DWC3 USB SoC controller
 
 Required properties:
-- compatible:	should contain "rockchip,rk3399-dwc3" for rk3399 SoC
+- compatible:	should be one of the following:
+  - "rockchip,rk3399-dwc3": for rk3399 SoC
+  - "rockchip,rk3328-dwc3", "rockchip,rk3399-dwc3": for rk3328 SoC
 - clocks:	A list of phandle + clock-specifier pairs for the
 		clocks listed in clock-names
 - clock-names:	Should contain the following:
-- 
2.0.0
