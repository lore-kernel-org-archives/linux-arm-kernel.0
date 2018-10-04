From: jolly.shah@xilinx.com (Jolly Shah)
Date: Thu, 4 Oct 2018 14:23:40 -0700
Subject: [PATCH v3 3/4] firmware: xilinx: Add node IDs for zynqmp firmware
In-Reply-To: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
References: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
Message-ID: <1538688221-9823-4-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Xilinx ZynqMP firmware has different node IDs for different
peripherals. Add node IDs which can be used by any driver.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 72 ++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 6998f7d..14bb780 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -40,6 +40,78 @@
 #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
 #define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
 
+/* Node IDs */
+#define NODE_UNKNOWN    0
+#define NODE_APU        1
+#define NODE_APU_0      2
+#define NODE_APU_1      3
+#define NODE_APU_2      4
+#define NODE_APU_3      5
+#define NODE_RPU        6
+#define NODE_RPU_0      7
+#define NODE_RPU_1      8
+#define NODE_PLD        9
+#define NODE_FPD        10
+#define NODE_OCM_BANK_0 11
+#define NODE_OCM_BANK_1 12
+#define NODE_OCM_BANK_2 13
+#define NODE_OCM_BANK_3 14
+#define NODE_TCM_0_A    15
+#define NODE_TCM_0_B    16
+#define NODE_TCM_1_A    17
+#define NODE_TCM_1_B    18
+#define NODE_L2         19
+#define NODE_GPU_PP_0   20
+#define NODE_GPU_PP_1   21
+#define NODE_USB_0      22
+#define NODE_USB_1      23
+#define NODE_TTC_0      24
+#define NODE_TTC_1      25
+#define NODE_TTC_2      26
+#define NODE_TTC_3      27
+#define NODE_SATA       28
+#define NODE_ETH_0      29
+#define NODE_ETH_1      30
+#define NODE_ETH_2      31
+#define NODE_ETH_3      32
+#define NODE_UART_0     33
+#define NODE_UART_1     34
+#define NODE_SPI_0      35
+#define NODE_SPI_1      36
+#define NODE_I2C_0      37
+#define NODE_I2C_1      38
+#define NODE_SD_0       39
+#define NODE_SD_1       40
+#define NODE_DP         41
+#define NODE_GDMA       42
+#define NODE_ADMA       43
+#define NODE_NAND       44
+#define NODE_QSPI       45
+#define NODE_GPIO       46
+#define NODE_CAN_0      47
+#define NODE_CAN_1      48
+#define NODE_EXTERN     49
+#define NODE_APLL       50
+#define NODE_VPLL       51
+#define NODE_DPLL       52
+#define NODE_RPLL       53
+#define NODE_IOPLL      54
+#define NODE_DDR        55
+#define NODE_IPI_APU    56
+#define NODE_IPI_RPU_0  57
+#define NODE_GPU        58
+#define NODE_PCIE       59
+#define NODE_PCAP       60
+#define NODE_RTC        61
+#define NODE_LPD        62
+#define NODE_VCU        63
+#define NODE_IPI_RPU_1  64
+#define NODE_IPI_PL_0   65
+#define NODE_IPI_PL_1   66
+#define NODE_IPI_PL_2   67
+#define NODE_IPI_PL_3   68
+#define NODE_PL         69
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_REQUEST_NODE = 13,
-- 
2.7.4
