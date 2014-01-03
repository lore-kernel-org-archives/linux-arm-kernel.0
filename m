From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:11:08 +0100
Subject: [PATCH v1 23/24] zynq-common: Enable verified boot(RSA)
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <f92e124bf9449a57d3d87fb81f2785807ec9eaa2.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

CONFIG_FIT_SIGNATURE - signature node support in FIT image
CONFIG_RSA - RSA lib support

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index b21e060..36caa36 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -193,6 +193,10 @@
 #define CONFIG_DISPLAY_BOARDINFO_LATE
 #define CONFIG_DEFAULT_DEVICE_TREE	"zynq-generic"

+/* RSA support */
+#define CONFIG_FIT_SIGNATURE
+#define CONFIG_RSA
+
 /* Boot FreeBSD/vxWorks from an ELF image */
 #if defined(CONFIG_ZYNQ_BOOT_FREEBSD)
 # define CONFIG_API
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/2c366c54/attachment.sig>
