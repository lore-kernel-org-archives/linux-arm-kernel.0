From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:51 +0100
Subject: [PATCH v1 06/24] zynq: Enable CONFIG_FIT_VERBOSE
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <4ad38abbd8d071f2eb6e623a5c757c6859c6aec0.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Enabled fit_format_{error,warning}()

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index 82ec826..6019c4a 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -127,6 +127,7 @@

 /* OF */
 #define CONFIG_FIT
+#define CONFIG_FIT_VERBOSE	1 /* enable fit_format_{error,warning}() */
 #define CONFIG_OF_LIBFDT

 /* Commands */
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/08c499a0/attachment.sig>
