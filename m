From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 30 Jul 2017 21:23:12 +0800
Subject: [PATCH v2 2/3] dt-bindings: add bindings document for zx-irdec
In-Reply-To: <1501420993-21977-1-git-send-email-shawnguo@kernel.org>
References: <1501420993-21977-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1501420993-21977-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds the dt-bindings document for ZTE ZX IRDEC remote control
block.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/media/zx-irdec.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/zx-irdec.txt

diff --git a/Documentation/devicetree/bindings/media/zx-irdec.txt b/Documentation/devicetree/bindings/media/zx-irdec.txt
new file mode 100644
index 000000000000..295b9fab593e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/zx-irdec.txt
@@ -0,0 +1,14 @@
+IR Decoder (IRDEC) on ZTE ZX family SoCs
+
+Required properties:
+ - compatible: Should be "zte,zx296718-irdec".
+ - reg: Physical base address and length of IRDEC registers.
+ - interrupts: Interrupt number of IRDEC.
+
+Exmaples:
+
+	irdec: ir-decoder at 111000 {
+		compatible = "zte,zx296718-irdec";
+		reg = <0x111000 0x1000>;
+		interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
1.9.1
