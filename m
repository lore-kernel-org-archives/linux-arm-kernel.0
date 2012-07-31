From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 31 Jul 2012 14:29:06 +0800
Subject: [PATCH 6/8] arm: mmp: remove unused definition in regs-apbc and
 regs-apmu
In-Reply-To: <1343716148-3899-1-git-send-email-xiechao.mail@gmail.com>
References: <1343716148-3899-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1343716148-3899-6-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/mach-mmp/include/mach/regs-apbc.h |   95 ----------------------------
 arch/arm/mach-mmp/include/mach/regs-apmu.h |   15 -----
 2 files changed, 0 insertions(+), 110 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/regs-apbc.h b/arch/arm/mach-mmp/include/mach/regs-apbc.h
index 68b0c93..ddc812f 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apbc.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apbc.h
@@ -13,101 +13,6 @@
 
 #include <mach/addr-map.h>
 
-/*
- * APB clock register offsets for PXA168
- */
-#define APBC_PXA168_UART1	APBC_REG(0x000)
-#define APBC_PXA168_UART2	APBC_REG(0x004)
-#define APBC_PXA168_GPIO	APBC_REG(0x008)
-#define APBC_PXA168_PWM1	APBC_REG(0x00c)
-#define APBC_PXA168_PWM2	APBC_REG(0x010)
-#define APBC_PXA168_PWM3	APBC_REG(0x014)
-#define APBC_PXA168_PWM4	APBC_REG(0x018)
-#define APBC_PXA168_RTC		APBC_REG(0x028)
-#define APBC_PXA168_TWSI0	APBC_REG(0x02c)
-#define APBC_PXA168_KPC		APBC_REG(0x030)
-#define APBC_PXA168_TIMERS	APBC_REG(0x034)
-#define APBC_PXA168_AIB		APBC_REG(0x03c)
-#define APBC_PXA168_SW_JTAG	APBC_REG(0x040)
-#define APBC_PXA168_ONEWIRE	APBC_REG(0x048)
-#define APBC_PXA168_ASFAR	APBC_REG(0x050)
-#define APBC_PXA168_ASSAR	APBC_REG(0x054)
-#define APBC_PXA168_TWSI1	APBC_REG(0x06c)
-#define APBC_PXA168_UART3	APBC_REG(0x070)
-#define APBC_PXA168_AC97	APBC_REG(0x084)
-#define APBC_PXA168_SSP1	APBC_REG(0x81c)
-#define APBC_PXA168_SSP2	APBC_REG(0x820)
-#define APBC_PXA168_SSP3	APBC_REG(0x84c)
-#define APBC_PXA168_SSP4	APBC_REG(0x858)
-#define APBC_PXA168_SSP5	APBC_REG(0x85c)
-
-/*
- * APB Clock register offsets for PXA910
- */
-#define APBC_PXA910_UART0	APBC_REG(0x000)
-#define APBC_PXA910_UART1	APBC_REG(0x004)
-#define APBC_PXA910_GPIO	APBC_REG(0x008)
-#define APBC_PXA910_PWM1	APBC_REG(0x00c)
-#define APBC_PXA910_PWM2	APBC_REG(0x010)
-#define APBC_PXA910_PWM3	APBC_REG(0x014)
-#define APBC_PXA910_PWM4	APBC_REG(0x018)
-#define APBC_PXA910_SSP1	APBC_REG(0x01c)
-#define APBC_PXA910_SSP2	APBC_REG(0x020)
-#define APBC_PXA910_IPC		APBC_REG(0x024)
-#define APBC_PXA910_RTC		APBC_REG(0x028)
-#define APBC_PXA910_TWSI0	APBC_REG(0x02c)
-#define APBC_PXA910_KPC		APBC_REG(0x030)
-#define APBC_PXA910_TIMERS	APBC_REG(0x034)
-#define APBC_PXA910_TBROT	APBC_REG(0x038)
-#define APBC_PXA910_AIB		APBC_REG(0x03c)
-#define APBC_PXA910_SW_JTAG	APBC_REG(0x040)
-#define APBC_PXA910_TIMERS1	APBC_REG(0x044)
-#define APBC_PXA910_ONEWIRE	APBC_REG(0x048)
-#define APBC_PXA910_SSP3	APBC_REG(0x04c)
-#define APBC_PXA910_ASFAR	APBC_REG(0x050)
-#define APBC_PXA910_ASSAR	APBC_REG(0x054)
-
-/*
- * APB Clock register offsets for MMP2
- */
-#define APBC_MMP2_RTC		APBC_REG(0x000)
-#define APBC_MMP2_TWSI1		APBC_REG(0x004)
-#define APBC_MMP2_TWSI2		APBC_REG(0x008)
-#define APBC_MMP2_TWSI3		APBC_REG(0x00c)
-#define APBC_MMP2_TWSI4		APBC_REG(0x010)
-#define APBC_MMP2_ONEWIRE	APBC_REG(0x014)
-#define APBC_MMP2_KPC		APBC_REG(0x018)
-#define APBC_MMP2_TB_ROTARY	APBC_REG(0x01c)
-#define APBC_MMP2_SW_JTAG	APBC_REG(0x020)
-#define APBC_MMP2_TIMERS	APBC_REG(0x024)
-#define APBC_MMP2_UART1		APBC_REG(0x02c)
-#define APBC_MMP2_UART2		APBC_REG(0x030)
-#define APBC_MMP2_UART3		APBC_REG(0x034)
-#define APBC_MMP2_GPIO		APBC_REG(0x038)
-#define APBC_MMP2_PWM0		APBC_REG(0x03c)
-#define APBC_MMP2_PWM1		APBC_REG(0x040)
-#define APBC_MMP2_PWM2		APBC_REG(0x044)
-#define APBC_MMP2_PWM3		APBC_REG(0x048)
-#define APBC_MMP2_SSP0		APBC_REG(0x04c)
-#define APBC_MMP2_SSP1		APBC_REG(0x050)
-#define APBC_MMP2_SSP2		APBC_REG(0x054)
-#define APBC_MMP2_SSP3		APBC_REG(0x058)
-#define APBC_MMP2_SSP4		APBC_REG(0x05c)
-#define APBC_MMP2_SSP5		APBC_REG(0x060)
-#define APBC_MMP2_AIB		APBC_REG(0x064)
-#define APBC_MMP2_ASFAR		APBC_REG(0x068)
-#define APBC_MMP2_ASSAR		APBC_REG(0x06c)
-#define APBC_MMP2_USIM		APBC_REG(0x070)
-#define APBC_MMP2_MPMU		APBC_REG(0x074)
-#define APBC_MMP2_IPC		APBC_REG(0x078)
-#define APBC_MMP2_TWSI5		APBC_REG(0x07c)
-#define APBC_MMP2_TWSI6		APBC_REG(0x080)
-#define APBC_MMP2_TWSI_INTSTS	APBC_REG(0x084)
-#define APBC_MMP2_UART4		APBC_REG(0x088)
-#define APBC_MMP2_RIPC		APBC_REG(0x08c)
-#define APBC_MMP2_THSENS1	APBC_REG(0x090)	/* Thermal Sensor */
-#define APBC_MMP2_THSENS_INTSTS	APBC_REG(0x0a4)
-
 /* Common APB clock register bit definitions */
 #define APBC_APBCLK	(1 << 0)  /* APB Bus Clock Enable */
 #define APBC_FNCLK	(1 << 1)  /* Functional Clock Enable */
diff --git a/arch/arm/mach-mmp/include/mach/regs-apmu.h b/arch/arm/mach-mmp/include/mach/regs-apmu.h
index 7af8deb..93c8d0e 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
@@ -13,21 +13,6 @@
 
 #include <mach/addr-map.h>
 
-/* Clock Reset Control */
-#define APMU_IRE	APMU_REG(0x048)
-#define APMU_LCD	APMU_REG(0x04c)
-#define APMU_CCIC	APMU_REG(0x050)
-#define APMU_SDH0	APMU_REG(0x054)
-#define APMU_SDH1	APMU_REG(0x058)
-#define APMU_USB	APMU_REG(0x05c)
-#define APMU_NAND	APMU_REG(0x060)
-#define APMU_DMA	APMU_REG(0x064)
-#define APMU_GEU	APMU_REG(0x068)
-#define APMU_BUS	APMU_REG(0x06c)
-#define APMU_SDH2	APMU_REG(0x0e8)
-#define APMU_SDH3	APMU_REG(0x0ec)
-#define APMU_ETH	APMU_REG(0x0fc)
-
 #define APMU_FNCLK_EN	(1 << 4)
 #define APMU_AXICLK_EN	(1 << 3)
 #define APMU_FNRST_DIS	(1 << 1)
-- 
1.7.0.4
