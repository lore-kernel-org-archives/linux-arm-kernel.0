From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 20 Apr 2016 17:32:17 +0200
Subject: [PATCH 12/14] phy: phy-stih41x-usb: DT spelling
 s/#phy-cell/#phy-cells/
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1461166339-11109-13-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt b/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
index 00944a05ee6b4998..744b4809542edd3b 100644
--- a/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
+++ b/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
@@ -17,7 +17,7 @@ Example:
 
 usb2_phy: usb2phy at 0 {
 	compatible	= "st,stih416-usb-phy";
-	#phy-cell	= <0>;
+	#phy-cells	= <0>;
 	st,syscfg	= <&syscfg_rear>;
 	clocks		= <&clk_sysin>;
 	clock-names	= "osc_phy";
-- 
1.9.1
