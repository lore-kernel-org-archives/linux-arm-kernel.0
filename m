From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 15:55:33 +0200
Subject: [RESEND PATCH 01/12] Documentation/devicetree: add a small note on PCI
Message-ID: <1366466133-15369-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Throw in a file with references to the IEEE binding documents.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/pci/pci.txt | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pci.txt

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
new file mode 100644
index 0000000..41aeed3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -0,0 +1,9 @@
+PCI bus bridges have standardized Device Tree bindings:
+
+PCI Bus Binding to: IEEE Std 1275-1994
+http://www.openfirmware.org/ofwg/bindings/pci/pci2_1.pdf
+
+And for the interrupt mapping part:
+
+Open Firmware Recommended Practice: Interrupt Mapping
+http://www.openfirmware.org/1275/practice/imap/imap0_9d.pdf
-- 
1.8.1.4
