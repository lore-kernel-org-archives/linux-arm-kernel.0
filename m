From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 2 Sep 2013 21:13:08 +0530
Subject: [PATCH 4/7] Documentation: dt bindings: move ..usb/usb-phy.txt to
 ..phy/omap-phy.txt
In-Reply-To: <1378136591-7463-1-git-send-email-kishon@ti.com>
References: <1378136591-7463-1-git-send-email-kishon@ti.com>
Message-ID: <1378136591-7463-5-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since now we have a separate folder for phy, move the PHY dt binding
documentation of OMAP to that folder.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/{usb/usb-phy.txt => phy/omap-phy.txt}        |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{usb/usb-phy.txt => phy/omap-phy.txt} (96%)

diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Documentation/devicetree/bindings/phy/omap-phy.txt
similarity index 96%
rename from Documentation/devicetree/bindings/usb/usb-phy.txt
rename to Documentation/devicetree/bindings/phy/omap-phy.txt
index 36bdb17..2c485ee 100644
--- a/Documentation/devicetree/bindings/usb/usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/omap-phy.txt
@@ -1,4 +1,4 @@
-USB PHY
+OMAP PHY: DT DOCUMENTATION FOR PHYs in OMAP PLATFORM
 
 OMAP USB2 PHY
 
-- 
1.7.10.4
