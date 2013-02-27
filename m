From: javier.martin@vista-silicon.com (Javier Martin)
Date: Wed, 27 Feb 2013 11:41:51 +0100
Subject: [PATCH v2 3/3] crypto: sahara: Add device tree binding for SAHARA2.
In-Reply-To: <1361961711-4603-1-git-send-email-javier.martin@vista-silicon.com>
References: <1361961711-4603-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1361961711-4603-4-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 .../devicetree/bindings/crypto/fsl-imx-sahara.txt  |   14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt

diff --git a/Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt b/Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt
new file mode 100644
index 0000000..44abf11
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt
@@ -0,0 +1,14 @@
+* Freescale i.MX SAHARA Cryptographic Accelerator
+
+Required properties:
+- compatible : Should be "fsl,<soc>-sahara"
+- reg : Should contain SAHARA registers location and length
+- interrupts : Should contain SAHARA interrupt number
+
+Example:
+
+sah at 10025000 {
+	compatible = "fsl,imx27-sahara";
+	reg = <	0x10025000 0x800>;
+	interrupts = <75>;
+};
-- 
1.7.9.5
