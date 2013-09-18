From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 18 Sep 2013 11:48:35 -0700
Subject: [PATCH v2 1/4] clockchips: Add FEAT_PERCPU clockevent flag
In-Reply-To: <1379530118-22813-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1379530118-22813-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1379530118-22813-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the flag CLOCK_EVT_FEAT_PERCPU which is supposed to be set for per
cpu clockevent devices.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 include/linux/clockchips.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 0857922..493aa02 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -60,6 +60,7 @@ enum clock_event_mode {
  * Core shall set the interrupt affinity dynamically in broadcast mode
  */
 #define CLOCK_EVT_FEAT_DYNIRQ		0x000020
+#define CLOCK_EVT_FEAT_PERCPU		0x000040
 
 /**
  * struct clock_event_device - clock event device descriptor
-- 
1.8.4
