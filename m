From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 15 Dec 2014 10:55:14 +0800
Subject: [PATCH 5/6] dt-bindings: Add documentation for Rockchip hdmi-audio
In-Reply-To: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1418612114-19692-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Required properties:
- compatible: platform specific
- cpu-of-node: the device node of cpu_dai
- codec-name: the dw-hdmi codec's device name
- codec-dai-name: the dw-hdmi codec's dai name

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---

 .../bindings/sound/rockchip,rockchip-hdmi-audio.txt      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-hdmi-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rockchip-hdmi-audio.txt b/Documentation/devicetree/bindings/sound/rockchip,rockchip-hdmi-audio.txt
new file mode 100644
index 0000000..674cff0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip,rockchip-hdmi-audio.txt
@@ -0,0 +1,16 @@
+Rockchip hdmi audio bindings
+
+Required properties:
+- compatible: platform specific
+- cpu-of-node: the device node of cpu_dai
+- codec-name: the dw-hdmi codec's device name
+- codec-dai-name: the dw-hdmi codec's dai name
+
+Example:
+
+sound {
+	compatible = "rockchip,rk3288-hdmi-audio";
+	cpu-of-node = <&i2s>;
+	codec-name = "dw-hdmi-audio";
+	codec-dai-name = "dw-hdmi-hifi";
+};
-- 
2.1.2
