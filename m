From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  3 Feb 2015 10:19:50 -0500
Subject: [PATCH v3 15/15] dt-bindings: Add documentation for Rockchip
 dw-hdmi-audio
In-Reply-To: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1422976790-30588-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Required properties:
- compatible: platform specific
- i2s-controller: the i2s controller device node

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3:
- modify cpu-of-node to i2s-controller

Changes in v2:
- remove codec-name and codec-dai-name
- rename rockchip,rockchip-hdmi-audio.txt to rockchip,rockchip-dw-hdmi-audio.txt

 .../bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt       | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt b/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
new file mode 100644
index 0000000..f0d23c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
@@ -0,0 +1,12 @@
+Rockchip hdmi audio bindings
+
+Required properties:
+- compatible: platform specific
+- i2s-controller: the i2s controller device node
+
+Example:
+
+sound {
+	compatible = "rockchip,rk3288-hdmi-audio";
+	i2s-controller = <&i2s>;
+};
-- 
2.1.2
