From: rogerq@ti.com (Roger Quadros)
Date: Fri, 7 Mar 2014 12:15:01 +0200
Subject: [PATCH v3 1/8] phy: omap-control: update dra7 and am437 usb2
 Documentation bindings
In-Reply-To: <1394187308-19622-1-git-send-email-rogerq@ti.com>
References: <1394187308-19622-1-git-send-email-rogerq@ti.com>
Message-ID: <1394187308-19622-2-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dra7-usb2 and am437-usb2 bindings have not yet been used.
Change them to be more elegant.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 5c5b1b0..073a623 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -9,9 +9,9 @@ Required properties:
                         e.g. USB2_PHY on OMAP5.
  "ti,control-phy-pipe3" - if it has DPLL and individual Rx & Tx power control
                         e.g. USB3 PHY and SATA PHY on OMAP5.
- "ti,control-phy-dra7usb2" - if it has power down register like USB2 PHY on
+ "ti,control-phy-usb2-dra7" - if it has power down register like USB2 PHY on
                         DRA7 platform.
- "ti,control-phy-am437usb2" - if it has power down register like USB2 PHY on
+ "ti,control-phy-usb2-am437" - if it has power down register like USB2 PHY on
                         AM437 platform.
  - reg : Address and length of the register set for the device. It contains
    the address of "otghs_control" for control-phy-otghs or "power" register
-- 
1.8.3.2
