From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri,  9 Oct 2015 08:18:20 -0600
Subject: [PATCH] coresight: etm3x: adding documentation for sysFS's cpu
 interface
Message-ID: <1444400300-9670-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Supplementing ABI documentation with a description of the newly
added interface.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
index 67e3557bc4bf..924265a1295d 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
@@ -245,6 +245,12 @@ KernelVersion:	3.19
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description: 	(RW) Define the event that controls the trigger.
 
+What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/cpu
+Date:		October 2015
+KernelVersion:	4.4
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(RO) Holds the cpu number this tracer is affined to.
+
 What:		/sys/bus/coresight/devices/<memory_map>.[etm|ptm]/mgmt/etmccr
 Date:		September 2015
 KernelVersion:	4.4
-- 
1.9.1
