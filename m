From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Tue, 10 Jul 2018 14:58:48 +0200
Subject: [PATCH] usb: dwc3: rockchip: Fix PHY documentation links.
Message-ID: <20180710125848.15915-1-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 34962fb8070c ("docs: Fix more broken references") replaced the
broken reference to rockchip,dwc3-usb-phy.txt binding for the Qualcomm
DWC3 binding (qcom-dwc3-usb-phy.txt). That's wrong, so replace that
reference for the correct ones.

Fixes: 34962fb8070c ("docs: Fix more broken references")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 Documentation/devicetree/bindings/usb/rockchip,dwc3.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
index 252a05c5d976..c8c4b00ecb94 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
@@ -16,7 +16,8 @@ A child node must exist to represent the core DWC3 IP block. The name of
 the node is not important. The content of the node is defined in dwc3.txt.
 
 Phy documentation is provided in the following places:
-Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
+Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt - USB2.0 PHY
+Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt     - Type-C PHY
 
 Example device nodes:
 
-- 
2.18.0
