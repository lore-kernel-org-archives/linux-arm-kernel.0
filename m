From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 4 Mar 2015 12:42:13 -0800
Subject: [PATCH v3 1/2] hwrng: iproc-rng200 - Add device tree bindings
In-Reply-To: <1425501734-14025-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1425501734-14025-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1425501734-14025-2-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documents the IPROC random number generator device tree bindings
used in some Broadcom chipsets.

Reviewed-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 .../devicetree/bindings/hwrng/brcm,iproc-rng200.txt          | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwrng/brcm,iproc-rng200.txt

diff --git a/Documentation/devicetree/bindings/hwrng/brcm,iproc-rng200.txt b/Documentation/devicetree/bindings/hwrng/brcm,iproc-rng200.txt
new file mode 100644
index 0000000..e25a456
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwrng/brcm,iproc-rng200.txt
@@ -0,0 +1,12 @@
+HWRNG support for the iproc-rng200 driver
+
+Required properties:
+- compatible : "brcm,iproc-rng200"
+- reg : base address and size of control register block
+
+Example:
+
+rng {
+        compatible = "brcm,iproc-rng200";
+        reg = <0x18032000 0x28>;
+};
-- 
2.3.0
