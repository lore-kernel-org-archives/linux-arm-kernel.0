From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 26 Oct 2016 18:13:59 +0000
Subject: [PATCH 1/2] DT: binding: bcm2835-mbox: fix address typo in example
Message-ID: <1477505640-26658-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address of the mailbox node in the example has a typo.
So fix it accordingly.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: d4b5c782b9f4 ("dt/bindings: Add binding for the BCM2835 mailbox driver")
---
 .../bindings/mailbox/brcm,bcm2835-mbox.txt         |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
index e893615..b48d7d3 100644
--- a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
@@ -12,7 +12,7 @@ Required properties:
 
 Example:
 
-mailbox: mailbox at 7e00b800 {
+mailbox: mailbox at 7e00b880 {
 	compatible = "brcm,bcm2835-mbox";
 	reg = <0x7e00b880 0x40>;
 	interrupts = <0 1>;
-- 
1.7.9.5
