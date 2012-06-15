From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Jun 2012 00:33:05 -0300
Subject: [PATCH 5/5] dt: fsl-mxs-auart.txt: Add documentation for mxs-auart
 binding
In-Reply-To: <1339731185-4889-1-git-send-email-festevam@gmail.com>
References: <1339731185-4889-1-git-send-email-festevam@gmail.com>
Message-ID: <1339731185-4889-5-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add documentation for mxs-auart binding.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 .../bindings/tty/serial/fsl-mxs-auart.txt          |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
new file mode 100644
index 0000000..f529bb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
@@ -0,0 +1,14 @@
+* Freescale MXS Application UART (AUART)
+
+Required properties:
+- compatible : Should be "fsl,mxs-uart"
+- reg : Address and length of the register set for the device
+- interrupts : Should contain the auart interrupt
+
+Example:
+auart0: serial at 8006a000 {
+	compatible = "fsl,mxs-auart";
+	reg = <0x8006a000 0x2000>;
+	interrupts = <112 70 71>;
+};
+
-- 
1.7.1
