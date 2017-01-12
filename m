From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Thu, 12 Jan 2017 16:36:19 -0600
Subject: [PATCH v2 16/18] drivers/fsi: Document FSI master sysfs files in ABI
Message-ID: <1484260579-80359-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Bostic <cbostic@us.ibm.com>

Add info for sysfs scan file in Documentaiton ABI/testing

Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
---
 Documentation/ABI/testing/sysfs-bus-fsi | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-fsi

diff --git a/Documentation/ABI/testing/sysfs-bus-fsi b/Documentation/ABI/testing/sysfs-bus-fsi
new file mode 100644
index 0000000..dfcbc1b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-fsi
@@ -0,0 +1,6 @@
+What:           /sys/bus/platform/devices/fsi-master/scan
+KernelVersion:  4.9
+Contact:        cbostic at us.ibm.com
+Description:
+                Initiates a FSI master scan for all connected
+                slave devices on its links.
-- 
1.8.2.2
