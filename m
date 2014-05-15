From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 May 2014 12:17:30 +0200
Subject: [PATCH v6 05/17] Documentation: dt-bindings: update ehci-orion
 binding documentation
In-Reply-To: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
References: <1400149062-32661-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1400149062-32661-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This commit updates the Device Tree binding documentation of
ehci-orion to take into account the fact that we can now optionally
pass a clock and a PHY reference.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 Documentation/devicetree/bindings/usb/ehci-orion.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ehci-orion.txt b/Documentation/devicetree/bindings/usb/ehci-orion.txt
index 6bc09ec14c4d..17c3bc858b86 100644
--- a/Documentation/devicetree/bindings/usb/ehci-orion.txt
+++ b/Documentation/devicetree/bindings/usb/ehci-orion.txt
@@ -6,6 +6,11 @@ Required properties:
   region.
 - interrupts: The EHCI interrupt
 
+Optional properties:
+- clocks: reference to the clock
+- phys: reference to the USB PHY
+- phy-names: name of the USB PHY, should be "usb"
+
 Example:
 
 	ehci at 50000 {
-- 
1.8.1.2
