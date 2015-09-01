From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue,  1 Sep 2015 17:57:29 +0800
Subject: [PATCH v3 4/9] Documentation: rockchip-i2s: add description of
 rockchip, i2s-broken-burst-len
In-Reply-To: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1441101449-1506-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
cc: Addy Ke <addy.ke@rock-chips.com>
cc: Jianqun Xu <xjq@rock-chips.com>
cc: Heiko Stuebner <heiko@sntech.de>
cc: Doug Anderson <dianders@chromium.org>
cc: Olof Johansson <olof@lixom.net>
cc: Sonny Rao <sonnyrao@chromium.org>
---

Changes in v3: None
Changes in v2: None
Changes in v1: None

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 9b82c20..9987787 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -22,6 +22,10 @@ Required properties:
    - "i2s_hclk": clock for I2S BUS
    - "i2s_clk" : clock for I2S controller
 
+Optional Properties:
+- rockchip,i2s-broken-burst-len: quirk for broken burst len on Rockchip platform.
+				 Add this property will force driver to set burst ONE.
+
 Example for rk3288 I2S controller:
 
 i2s at ff890000 {
-- 
2.3.7
