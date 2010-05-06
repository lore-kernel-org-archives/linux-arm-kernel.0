From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:06 -0700
Subject: [PATCH 15/34] Davinci: tnetv107x IRQ definitions
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-16-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

IRQ numbers as defined for tnetv107x cp_intc.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/include/mach/irqs.h |   97 +++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
index 354af71..ec76c77 100644
--- a/arch/arm/mach-davinci/include/mach/irqs.h
+++ b/arch/arm/mach-davinci/include/mach/irqs.h
@@ -401,6 +401,103 @@
 
 #define DA850_N_CP_INTC_IRQ		101
 
+
+/* TNETV107X specific interrupts */
+#define IRQ_TNETV107X_TDM1_TXDMA		0
+#define IRQ_TNETV107X_EXT_INT_0			1
+#define IRQ_TNETV107X_EXT_INT_1			2
+#define IRQ_TNETV107X_GPIO_INT12		3
+#define IRQ_TNETV107X_GPIO_INT13		4
+#define IRQ_TNETV107X_TIMER_0_TINT12		5
+#define IRQ_TNETV107X_TIMER_1_TINT12		6
+#define IRQ_TNETV107X_UART0			7
+#define IRQ_TNETV107X_TDM1_RXDMA		8
+#define IRQ_TNETV107X_MCDMA_INT0		9
+#define IRQ_TNETV107X_MCDMA_INT1		10
+#define IRQ_TNETV107X_TPCC			11
+#define IRQ_TNETV107X_TPCC_INT0			12
+#define IRQ_TNETV107X_TPCC_INT1			13
+#define IRQ_TNETV107X_TPCC_INT2			14
+#define IRQ_TNETV107X_TPCC_INT3			15
+#define IRQ_TNETV107X_TPTC0			16
+#define IRQ_TNETV107X_TPTC1			17
+#define IRQ_TNETV107X_TIMER_0_TINT34		18
+#define IRQ_TNETV107X_ETHSS			19
+#define IRQ_TNETV107X_TIMER_1_TINT34		20
+#define IRQ_TNETV107X_DSP2ARM_INT0		21
+#define IRQ_TNETV107X_DSP2ARM_INT1		22
+#define IRQ_TNETV107X_ARM_NPMUIRQ		23
+#define IRQ_TNETV107X_USB1			24
+#define IRQ_TNETV107X_VLYNQ			25
+#define IRQ_TNETV107X_UART0_DMATX		26
+#define IRQ_TNETV107X_UART0_DMARX		27
+#define IRQ_TNETV107X_TDM1_TXMCSP		28
+#define IRQ_TNETV107X_SSP			29
+#define IRQ_TNETV107X_MCDMA_INT2		30
+#define IRQ_TNETV107X_MCDMA_INT3		31
+#define IRQ_TNETV107X_TDM_CODECIF_EOT		32
+#define IRQ_TNETV107X_IMCOP_SQR_ARM		33
+#define IRQ_TNETV107X_USB0			34
+#define IRQ_TNETV107X_USB_CDMA			35
+#define IRQ_TNETV107X_LCD			36
+#define IRQ_TNETV107X_KEYPAD			37
+#define IRQ_TNETV107X_KEYPAD_FREE		38
+#define IRQ_TNETV107X_RNG			39
+#define IRQ_TNETV107X_PKA			40
+#define IRQ_TNETV107X_TDM0_TXDMA		41
+#define IRQ_TNETV107X_TDM0_RXDMA		42
+#define IRQ_TNETV107X_TDM0_TXMCSP		43
+#define IRQ_TNETV107X_TDM0_RXMCSP		44
+#define IRQ_TNETV107X_TDM1_RXMCSP		45
+#define IRQ_TNETV107X_SDIO1			46
+#define IRQ_TNETV107X_SDIO0			47
+#define IRQ_TNETV107X_TSC			48
+#define IRQ_TNETV107X_TS			49
+#define IRQ_TNETV107X_UART1			50
+#define IRQ_TNETV107X_MBX_LITE			51
+#define IRQ_TNETV107X_GPIO_INT00		52
+#define IRQ_TNETV107X_GPIO_INT01		53
+#define IRQ_TNETV107X_GPIO_INT02		54
+#define IRQ_TNETV107X_GPIO_INT03		55
+#define IRQ_TNETV107X_UART2			56
+#define IRQ_TNETV107X_UART2_DMATX		57
+#define IRQ_TNETV107X_UART2_DMARX		58
+#define IRQ_TNETV107X_IMCOP_IMX			59
+#define IRQ_TNETV107X_IMCOP_VLCD		60
+#define IRQ_TNETV107X_AES			61
+#define IRQ_TNETV107X_DES			62
+#define IRQ_TNETV107X_SHAMD5			63
+#define IRQ_TNETV107X_TPCC_ERR			68
+#define IRQ_TNETV107X_TPCC_PROT			69
+#define IRQ_TNETV107X_TPTC0_ERR			70
+#define IRQ_TNETV107X_TPTC1_ERR			71
+#define IRQ_TNETV107X_UART0_ERR			72
+#define IRQ_TNETV107X_UART1_ERR			73
+#define IRQ_TNETV107X_AEMIF_ERR			74
+#define IRQ_TNETV107X_DDR_ERR			75
+#define IRQ_TNETV107X_WDTARM_INT0		76
+#define IRQ_TNETV107X_MCDMA_ERR			77
+#define IRQ_TNETV107X_GPIO_ERR			78
+#define IRQ_TNETV107X_MPU_ADDR			79
+#define IRQ_TNETV107X_MPU_PROT			80
+#define IRQ_TNETV107X_IOPU_ADDR			81
+#define IRQ_TNETV107X_IOPU_PROT			82
+#define IRQ_TNETV107X_KEYPAD_ADDR_ERR		83
+#define IRQ_TNETV107X_WDT0_ADDR_ERR		84
+#define IRQ_TNETV107X_WDT1_ADDR_ERR		85
+#define IRQ_TNETV107X_CLKCTL_ADDR_ERR		86
+#define IRQ_TNETV107X_PLL_UNLOCK		87
+#define IRQ_TNETV107X_WDTDSP_INT0		88
+#define IRQ_TNETV107X_SEC_CTRL_VIOLATION	89
+#define IRQ_TNETV107X_KEY_MNG_VIOLATION		90
+#define IRQ_TNETV107X_PBIST_CPU			91
+#define IRQ_TNETV107X_WDTARM			92
+#define IRQ_TNETV107X_PSC			93
+#define IRQ_TNETV107X_MMC0			94
+#define IRQ_TNETV107X_MMC1			95
+
+#define TNETV107X_N_CP_INTC_IRQ			96
+
 /* da850 currently has the most gpio pins (144) */
 #define DAVINCI_N_GPIO			144
 /* da850 currently has the most irqs so use DA850_N_CP_INTC_IRQ */
-- 
1.7.0.2
