From: cl@rock-chips.com (cl at rock-chips.com)
Date: Mon, 23 Jul 2018 17:25:19 +0800
Subject: [PATCH v2 1/6] dt-bindings: usb: dwc2: add description for px30
In-Reply-To: <1532337924-4185-1-git-send-email-cl@rock-chips.com>
References: <1532337924-4185-1-git-send-email-cl@rock-chips.com>
Message-ID: <1532337924-4185-2-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

This patch adds the compatible of dwc2 for PX30 SoCs.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 46da5f1..6dc3c4a 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -6,6 +6,7 @@ Required properties:
   - brcm,bcm2835-usb: The DWC2 USB controller instance in the BCM2835 SoC.
   - hisilicon,hi6220-usb: The DWC2 USB controller instance in the hi6220 SoC.
   - rockchip,rk3066-usb: The DWC2 USB controller instance in the rk3066 Soc;
+  - "rockchip,px30-usb", "rockchip,rk3066-usb", "snps,dwc2": for px30 Soc;
   - "rockchip,rk3188-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3188 Soc;
   - "rockchip,rk3288-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3288 Soc;
   - "lantiq,arx100-usb": The DWC2 USB controller instance in Lantiq ARX SoCs;
-- 
1.9.1
