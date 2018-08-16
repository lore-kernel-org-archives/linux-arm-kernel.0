From: wendy.liang@xilinx.com (Wendy Liang)
Date: Thu, 16 Aug 2018 00:06:26 -0700
Subject: [PATCH 3/7] firmware: xilinx-zynqmp: Add request access capability
 macro
In-Reply-To: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
Message-ID: <1534403190-28523-4-git-send-email-jliang@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add request access capability macro which will be used to
request access to a device node from Xilinx firmware.

Signed-off-by: Wendy Liang <jliang@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index e3b7292..83ebadf 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -32,6 +32,9 @@
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+/* Request capability of a device node */
+#define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
+
 enum zynqmp_pm_request_ack {
 	ZYNQMP_PM_REQUEST_ACK_NO = 1,
 	ZYNQMP_PM_REQUEST_ACK_BLOCKING,
-- 
2.7.4
