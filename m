From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  7 May 2014 15:52:11 +0200
Subject: [PATCHv4 05/20] Documentation: dt-bindings: update ehci-orion binding
 documentation
In-Reply-To: <1399470746-2948-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399470746-2948-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399470746-2948-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit updates the Device Tree binding documentation of
ehci-orion to take into account the fact that we can now optionally
pass a clock and a PHY reference.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/usb/ehci-orion.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ehci-orion.txt b/Documentation/devicetree/bindings/usb/ehci-orion.txt
index 6bc09ec..17c3bc8 100644
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
1.9.2
