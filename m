From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:11:05 +0100
Subject: [PATCH v1 20/24] zynq-common: Define CONFIG_ENV_OVERWRITE
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <08505bb99057204edd804585d5648382eecc494d.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Defined CONFIG_ENV_OVERWRITE, which allow to
overwrite serial baudrate and ethaddr.

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index 2e82073..ed7de6c 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -109,6 +109,9 @@
 /* Total Size of Environment Sector */
 #define CONFIG_ENV_SIZE			(128 << 10)

+/* Allow to overwrite serial and ethaddr */
+#define CONFIG_ENV_OVERWRITE
+
 /* Environment */
 #ifndef CONFIG_ENV_IS_NOWHERE
 # ifndef CONFIG_SYS_NO_FLASH
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/f7f01945/attachment.sig>
