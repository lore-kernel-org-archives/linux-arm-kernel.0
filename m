From: atull@opensource.altera.com (Alan Tull)
Date: Tue, 12 Jul 2016 14:36:42 -0500
Subject: [PATCH v18 3/6] add sysfs document for fpga bridge class
In-Reply-To: <20160712193645.9098-1-atull@opensource.altera.com>
References: <20160712193645.9098-1-atull@opensource.altera.com>
Message-ID: <20160712193645.9098-4-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for new FPGA bridge class's sysfs interface.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
--
v15: Document added in v15 of patch set
v16: No change to this patch in v16 of patch set
v17: No change to this patch in v17 of patch set
v18: No change to this patch in v18 of patch set
---
 Documentation/ABI/testing/sysfs-class-fpga-bridge | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-bridge

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-bridge b/Documentation/ABI/testing/sysfs-class-fpga-bridge
new file mode 100644
index 0000000..312ae2c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-fpga-bridge
@@ -0,0 +1,11 @@
+What:		/sys/class/fpga_bridge/<bridge>/name
+Date:		January 2016
+KernelVersion:	4.5
+Contact:	Alan Tull <atull@opensource.altera.com>
+Description:	Name of low level FPGA bridge driver.
+
+What:		/sys/class/fpga_bridge/<bridge>/state
+Date:		January 2016
+KernelVersion:	4.5
+Contact:	Alan Tull <atull@opensource.altera.com>
+Description:	Show bridge state as "enabled" or "disabled"
-- 
2.9.1
