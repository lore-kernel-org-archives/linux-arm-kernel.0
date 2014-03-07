From: rogerq@ti.com (Roger Quadros)
Date: Fri, 7 Mar 2014 12:15:03 +0200
Subject: [PATCH v3 3/8] phy: ti-pipe3: Add SATA compatible to Documentation
 binding
In-Reply-To: <1394187308-19622-1-git-send-email-rogerq@ti.com>
References: <1394187308-19622-1-git-send-email-rogerq@ti.com>
Message-ID: <1394187308-19622-4-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SATA PHY needs a new compatible ID. Add it to the DT binding documentation.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 96ba29e..4ab9cb1 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -53,7 +53,8 @@ usb2phy at 4a0ad080 {
 TI PIPE3 PHY
 
 Required properties:
- - compatible: Should be "ti,phy-usb3". "ti,omap-usb3" is deprecated.
+ - compatible: Should be "ti,phy-usb3" or "ti,phy-pipe3-sata".
+   "ti,omap-usb3" is deprecated.
  - reg : Address and length of the register set for the device.
  - reg-names: The names of the register addresses corresponding to the registers
    filled in "reg".
-- 
1.8.3.2
