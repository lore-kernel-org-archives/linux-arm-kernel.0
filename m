From: sourav.poddar@ti.com (Sourav Poddar)
Date: Tue, 14 Aug 2012 21:53:32 +0530
Subject: [PATCH] Documentation: dt: hwmon: Update for tmp102
Message-ID: <1344961412-13622-1-git-send-email-sourav.poddar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Documentation for tmp102 temperature sensor.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 Documentation/devicetree/bindings/hwmon/tmp102.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/tmp102.txt

diff --git a/Documentation/devicetree/bindings/hwmon/tmp102.txt b/Documentation/devicetree/bindings/hwmon/tmp102.txt
new file mode 100644
index 0000000..df1342b
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/tmp102.txt
@@ -0,0 +1,11 @@
+TMP102 Temperature sensor
+
+Required properties:
+- compatible: ti,tmp102
+
+Example:
+
+tmp102 at 48 {
+        compatible = "ti,tmp102";
+        reg = <0x48>;
+};
-- 
1.7.1
