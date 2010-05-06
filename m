From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:05 -0700
Subject: [PATCH 14/34] Davinci: tnetv107x LPSC modules
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-15-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

Added definitions for LPSC modules in the tnetv107x SOC

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/include/mach/psc.h |   47 ++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
index 7dd2962..983da6e 100644
--- a/arch/arm/mach-davinci/include/mach/psc.h
+++ b/arch/arm/mach-davinci/include/mach/psc.h
@@ -180,6 +180,53 @@
 #define DA8XX_LPSC1_CR_P3_SS		26
 #define DA8XX_LPSC1_L3_CBA_RAM		31
 
+/* TNETV107X LPSC Assignments */
+#define TNETV107X_LPSC_ARM			0
+#define TNETV107X_LPSC_GEM			1
+#define TNETV107X_LPSC_DDR2_PHY			2
+#define TNETV107X_LPSC_TPCC			3
+#define TNETV107X_LPSC_TPTC0			4
+#define TNETV107X_LPSC_TPTC1			5
+#define TNETV107X_LPSC_RAM			6
+#define TNETV107X_LPSC_MBX_LITE			7
+#define TNETV107X_LPSC_LCD			8
+#define TNETV107X_LPSC_ETHSS			9
+#define TNETV107X_LPSC_AEMIF			10
+#define TNETV107X_LPSC_CHIP_CFG			11
+#define TNETV107X_LPSC_TSC			12
+#define TNETV107X_LPSC_ROM			13
+#define TNETV107X_LPSC_UART2			14
+#define TNETV107X_LPSC_PKTSEC			15
+#define TNETV107X_LPSC_SECCTL			16
+#define TNETV107X_LPSC_KEYMGR			17
+#define TNETV107X_LPSC_KEYPAD			18
+#define TNETV107X_LPSC_GPIO			19
+#define TNETV107X_LPSC_MDIO			20
+#define TNETV107X_LPSC_SDIO0			21
+#define TNETV107X_LPSC_UART0			22
+#define TNETV107X_LPSC_UART1			23
+#define TNETV107X_LPSC_TIMER0			24
+#define TNETV107X_LPSC_TIMER1			25
+#define TNETV107X_LPSC_WDT_ARM			26
+#define TNETV107X_LPSC_WDT_DSP			27
+#define TNETV107X_LPSC_SSP			28
+#define TNETV107X_LPSC_TDM0			29
+#define TNETV107X_LPSC_VLYNQ			30
+#define TNETV107X_LPSC_MCDMA			31
+#define TNETV107X_LPSC_USB0			32
+#define TNETV107X_LPSC_TDM1			33
+#define TNETV107X_LPSC_DEBUGSS			34
+#define TNETV107X_LPSC_ETHSS_RGMII		35
+#define TNETV107X_LPSC_SYSTEM			36
+#define TNETV107X_LPSC_IMCOP			37
+#define TNETV107X_LPSC_SPARE			38
+#define TNETV107X_LPSC_SDIO1			39
+#define TNETV107X_LPSC_USB1			40
+#define TNETV107X_LPSC_USBSS			41
+#define TNETV107X_LPSC_DDR2_EMIF1_VRST		42
+#define TNETV107X_LPSC_DDR2_EMIF2_VCTL_RST	43
+#define TNETV107X_LPSC_MAX			44
+
 /* PSC register offsets */
 #define EPCPR		0x070
 #define PTCMD		0x120
-- 
1.7.0.2
