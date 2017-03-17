From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Fri, 17 Mar 2017 15:08:21 +0100
Subject: [PATCH v3 08/11] ASoC: Add bindings for DMIC codec driver
In-Reply-To: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <1489759704-30217-9-git-send-email-arnaud.pouliquen@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation of device tree bindings for audio DMIC codec.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 Documentation/devicetree/bindings/sound/dmic.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/dmic.txt

diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
new file mode 100644
index 0000000..eb2a9d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/dmic.txt
@@ -0,0 +1,11 @@
+Device-Tree bindings for dmic codec
+
+Required properties:
+	- compatible: should be "dmic-codec".
+
+Example node:
+
+	dmic_audio: dmic_audio at 0 {
+		compatible = "dmic-codec";
+		status = "okay";
+	};
-- 
1.9.1
