From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:11:00 +0100
Subject: [PATCH v1 15/24] zynq-common: Define exact TEXT_BASE
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <da8c55e59e770f17ba23459daa125ac3b9322137.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Defined TEXT_BASE for u-boot starts from 0x4000000
w.r.t zynq memory-map.

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 include/configs/zynq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index 2f8f4ab..c90d4fd 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -113,7 +113,7 @@
 					sizeof(CONFIG_SYS_PROMPT) + 16)

 /* Physical Memory map */
-#define CONFIG_SYS_TEXT_BASE		0
+#define CONFIG_SYS_TEXT_BASE		0x4000000

 #define CONFIG_NR_DRAM_BANKS		1
 #define CONFIG_SYS_SDRAM_BASE		0
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/cd4eda90/attachment.sig>
