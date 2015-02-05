From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu,  5 Feb 2015 22:46:57 +0800
Subject: [PATCH 1/4] Documentation: dt-bindings: add dt binding info for
 hi6220 dwc2
In-Reply-To: <1423147620-5760-1-git-send-email-zhangfei.gao@linaro.org>
References: <1423147620-5760-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1423147620-5760-2-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add necessary dwc2 binding documentation for Hisilicon soc: hi6220

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index fd132cb..2213682 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -4,6 +4,7 @@ Platform DesignWare HS OTG USB 2.0 controller
 Required properties:
 - compatible : One of:
   - brcm,bcm2835-usb: The DWC2 USB controller instance in the BCM2835 SoC.
+  - hisilicon,hi6220-usb: The DWC2 USB controller instance in the hi6220 SoC.
   - rockchip,rk3066-usb: The DWC2 USB controller instance in the rk3066 Soc;
   - "rockchip,rk3188-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3188 Soc;
   - "rockchip,rk3288-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3288 Soc;
-- 
1.9.1
