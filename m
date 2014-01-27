From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 27 Jan 2014 09:34:49 +0100
Subject: [PATCH 3/4] ASoC: tda998x: add DT documentation
In-Reply-To: <cover.1390813480.git.moinejf@free.fr>
References: <cover.1390813480.git.moinejf@free.fr>
Message-ID: <22fafd7e11771ffc25c84ff609d18039f07b7295.1390813481.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree documentation about the NXP TDA998x CODEC.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/sound/tda998x.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda998x.txt

diff --git a/Documentation/devicetree/bindings/sound/tda998x.txt b/Documentation/devicetree/bindings/sound/tda998x.txt
new file mode 100644
index 0000000..30273a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tda998x.txt
@@ -0,0 +1,14 @@
+Device-Tree bindings for the NXP TDA998x HDMI transmitter
+
+Required properties:
+	- compatible: must be "nxp,tda998x-codec".
+	- audio-ports: one or two values.
+		The first value defines the I2S input port.
+		The second one, if present, defines the S/PDIF input port.
+
+Example node:
+
+	hdmi_codec: hdmi-codec {
+		compatible = "nxp,tda998x-codec";
+		audio-ports = <0x03>, <0x04>;
+	};
-- 
1.8.5.3
