From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue,  1 Sep 2015 17:57:19 +0800
Subject: [PATCH v3 3/9] Documentation: spi-rockchip: add description of
 rockchip, spi-broken-burst-len
In-Reply-To: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1441101439-1465-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
cc: Addy Ke <addy.ke@rock-chips.com>
cc: Heiko Stuebner <heiko@sntech.de>
cc: Doug Anderson <dianders@chromium.org>
cc: Olof Johansson <olof@lixom.net>
cc: Sonny Rao <sonnyrao@chromium.org>
---

Changes in v3: None
Changes in v2: None
Changes in v1: None

 Documentation/devicetree/bindings/spi/spi-rockchip.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
index 0c491bd..2256610 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -27,7 +27,8 @@ Optional Properties:
 - rx-sample-delay-ns: nanoseconds to delay after the SCLK edge before sampling
 		Rx data (may need to be fine tuned for high capacitance lines).
 		No delay (0) by default.
-
+- rockchip,spi-broken-burst-len: quirk for broken burst len on Rockchip platform.
+			Add this property will force driver to set burst ONE.
 
 Example:
 
-- 
2.3.7
