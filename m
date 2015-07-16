From: standby24x7@gmail.com (Masanari Iida)
Date: Thu, 16 Jul 2015 19:57:46 +0900
Subject: [PATCH] Doc: trace: Fix typo in coresight.txt
Message-ID: <1437044266-17500-1-git-send-email-standby24x7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix spelling typos found in coresight.txt

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/trace/coresight.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 77d14d5..0a5c329 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -15,7 +15,7 @@ HW assisted tracing is becoming increasingly useful when dealing with systems
 that have many SoCs and other components like GPU and DMA engines.  ARM has
 developed a HW assisted tracing solution by means of different components, each
 being added to a design at synthesis time to cater to specific tracing needs.
-Compoments are generally categorised as source, link and sinks and are
+Components are generally categorised as source, link and sinks and are
 (usually) discovered using the AMBA bus.
 
 "Sources" generate a compressed stream representing the processor instruction
@@ -138,7 +138,7 @@ void coresight_unregister(struct coresight_device *csdev);
 
 The registering function is taking a "struct coresight_device *csdev" and
 register the device with the core framework.  The unregister function takes
-a reference to a "strut coresight_device", obtained at registration time.
+a reference to a "struct coresight_device", obtained at registration time.
 
 If everything goes well during the registration process the new devices will
 show up under /sys/bus/coresight/devices, as showns here for a TC2 platform:
-- 
2.5.0.rc2.13.g961abca
