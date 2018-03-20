From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue, 20 Mar 2018 13:03:32 -0300
Subject: [PATCH 3/3] dt-bindings: sound: rockchip Fix compatible string in
 example
In-Reply-To: <20180320160332.13212-1-ezequiel@vanguardiasur.com.ar>
References: <20180320160332.13212-1-ezequiel@vanguardiasur.com.ar>
Message-ID: <20180320160332.13212-4-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Use the correct compatible string in the example devicetree
snippet, which was probably overlooked.

Cc: devicetree at vger.kernel.org
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt
index 2539e1d68107..e5430d1d34e4 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt
@@ -22,7 +22,7 @@ Optionnal properties:
 Example:
 
 sound {
-	compatible = "rockchip,rockchip-audio-es8388";
+	compatible = "rockchip,rk3288-hdmi-analog";
 	rockchip,model = "Analog audio output";
 	rockchip,i2s-controller = <&i2s>;
 	rockchip,audio-codec = <&es8388>;
-- 
2.16.2
