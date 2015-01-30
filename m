From: ykk@rock-chips.com (Yakir Yang)
Date: Fri, 30 Jan 2015 06:44:13 -0500
Subject: [PATCH v2 12/12] dt-bindings: Add documentation for Rockchip
 dw-hdmi-audio
In-Reply-To: <1422617031-25098-1-git-send-email-ykk@rock-chips.com>
References: <1422617031-25098-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1422618253-27312-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Required properties:
- compatible: platform specific
- cpu-of-node: the device node of cpu_dai

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v2:
- remove codec-name and codec-dai-name
- rename rockchip,rockchip-hdmi-audio.txt to rockchip,rockchip-dw-hdmi-audio.txt

 .../bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt       | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt b/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
new file mode 100644
index 0000000..5b86eed
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
@@ -0,0 +1,12 @@
+Rockchip hdmi audio bindings
+
+Required properties:
+- compatible: platform specific
+- cpu-of-node: the device node of cpu_dai
+
+Example:
+
+sound {
+	compatible = "rockchip,rk3288-hdmi-audio";
+	cpu-of-node = <&i2s>;
+};
-- 
2.1.2
