From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 17 Aug 2016 10:59:00 +0200
Subject: [PATCH v2] dt-bindings: touchscreen: silead gsl1680: Document all
 compatibles
Message-ID: <1471424340-4201-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The silead gsl1680 driver / binding supports a whole series of devices,
list the compatibles for all of them in the binding.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Drop the "silead,mssl1680" compatible thing, the "mssl1680" name is an
 ACPI thing and does not belong in the dt bindings
---
 .../devicetree/bindings/input/touchscreen/silead_gsl1680.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
index b0eca54..ad7f41a 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
@@ -2,6 +2,10 @@
 
 Required properties:
 - compatible		  : "silead,gsl1680"
+			or: "silead,gsl1688"
+			or: "silead,gsl3670"
+			or: "silead,gsl3675"
+			or: "silead,gsl3692"
 - reg			  : I2C slave address of the chip (0x40)
 - interrupt-parent	  : a phandle pointing to the interrupt controller
 			    serving the interrupt for this chip
-- 
2.7.4
