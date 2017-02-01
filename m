From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Wed,  1 Feb 2017 10:53:57 -0600
Subject: [PATCH v3 17/18] drivers/fsi: Document FSI master sysfs files in ABI
In-Reply-To: <20170201165358.45415-1-cbostic@linux.vnet.ibm.com>
References: <20170201165358.45415-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170201165358.45415-18-cbostic@linux.vnet.ibm.com>
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
