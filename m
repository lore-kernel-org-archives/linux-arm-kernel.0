From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:11:03 +0100
Subject: [PATCH v1 18/24] zynq-common: Change Env. Sector size to 128Kb
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <9b18279d14485ff418e22b758c76695cccdfe242.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Changed Env. Sector size from 0x10000 to 128Kb

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index 5a33e15..a6caf0c 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -106,8 +106,10 @@
 #define CONFIG_BOOTP_HOSTNAME
 #define CONFIG_BOOTP_MAY_FAIL

+/* Total Size of Environment Sector */
+#define CONFIG_ENV_SIZE			(128 << 10)
+
 /* Environment */
-#define CONFIG_ENV_SIZE		0x10000 /* Env. sector size */
 #define CONFIG_ENV_IS_NOWHERE

 /* Default environment */
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/3005efb5/attachment.sig>
