From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Wed, 18 Jan 2017 17:39:38 -0800
Subject: [PATCH v2 1/3] dt-bindings: Document Broadcom iProc mailbox
 controller driver
In-Reply-To: <1484789980-6812-1-git-send-email-jonathan.richardson@broadcom.com>
References: <1484789980-6812-1-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <1484789980-6812-2-git-send-email-jonathan.richardson@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
---
 .../devicetree/bindings/mailbox/brcm,iproc-mailbox.txt     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt
new file mode 100644
index 0000000..f4c4f96
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt
@@ -0,0 +1,14 @@
+* Broadcom's iProc Mailbox Controller
+
+Required properties:
+- compatible: Must be "brcm,iproc-mailbox"
+- reg: Defines the base address of the mailbox controller.
+- #mbox-cells: Must be 1.
+
+Example:
+
+	mailbox: mailbox at 03024024 {
+		compatible = "brcm,iproc-mailbox";
+		reg = <0x03024024 0x8>;
+		#mbox-cells = <1>;
+	};
-- 
1.9.1
