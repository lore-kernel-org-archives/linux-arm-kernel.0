From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 31 Jul 2018 06:10:35 +0800
Subject: [PATCH] ARM: dts: imx7ulp: update pinfunc header file
Message-ID: <1532988635-4726-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX7ULP B0 chip has some pin changes for USB and VIU
module, update pinfunc header file accordingly.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7ulp-pinfunc.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7ulp-pinfunc.h b/arch/arm/boot/dts/imx7ulp-pinfunc.h
index fe51177..85f6b01 100644
--- a/arch/arm/boot/dts/imx7ulp-pinfunc.h
+++ b/arch/arm/boot/dts/imx7ulp-pinfunc.h
@@ -116,6 +116,7 @@
 #define IMX7ULP_PAD_PTC13__LPI2C7_SDA                                0x0034 0x030c 0x5 0x1
 #define IMX7ULP_PAD_PTC13__TPM7_CLKIN                                0x0034 0x02f4 0x6 0x1
 #define IMX7ULP_PAD_PTC13__FB_AD13                                   0x0034 0x0000 0x9 0x0
+#define IMX7ULP_PAD_PTC13__USB0_ID                                   0x0034 0x0338 0xb 0x1
 #define IMX7ULP_PAD_PTC14__PTC14                                     0x0038 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTC14__TRACE_D1                                  0x0038 0x0000 0xa 0x0
 #define IMX7ULP_PAD_PTC14__FXIO1_D10                                 0x0038 0x022c 0x2 0x1
@@ -136,6 +137,7 @@
 #define IMX7ULP_PAD_PTC16__LPSPI3_SIN                                0x0040 0x0324 0x3 0x1
 #define IMX7ULP_PAD_PTC16__TPM7_CH2                                  0x0040 0x02e4 0x6 0x1
 #define IMX7ULP_PAD_PTC16__FB_ALE_FB_CS1_B_FB_TS_B                   0x0040 0x0000 0x9 0x0
+#define IMX7ULP_PAD_PTC16__USB1_OC2                                  0x0040 0x0334 0xb 0x1
 #define IMX7ULP_PAD_PTC17__PTC17                                     0x0044 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTC17__FXIO1_D13                                 0x0044 0x0238 0x2 0x1
 #define IMX7ULP_PAD_PTC17__LPSPI3_SOUT                               0x0044 0x0328 0x3 0x1
@@ -146,11 +148,16 @@
 #define IMX7ULP_PAD_PTC18__LPSPI3_SCK                                0x0048 0x0320 0x3 0x1
 #define IMX7ULP_PAD_PTC18__TPM6_CH0                                  0x0048 0x02d0 0x6 0x1
 #define IMX7ULP_PAD_PTC18__FB_OE_B                                   0x0048 0x0000 0x9 0x0
+#define IMX7ULP_PAD_PTC18__USB0_ID                                   0x0048 0x0338 0xb 0x2
+#define IMX7ULP_PAD_PTC18__VIU_DE                                    0x0048 0x033c 0xc 0x1
 #define IMX7ULP_PAD_PTC19__PTC19                                     0x004c 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTC19__FXIO1_D15                                 0x004c 0x0240 0x2 0x1
 #define IMX7ULP_PAD_PTC19__LPSPI3_PCS0                               0x004c 0x0310 0x3 0x1
 #define IMX7ULP_PAD_PTC19__TPM6_CH1                                  0x004c 0x02d4 0x6 0x1
 #define IMX7ULP_PAD_PTC19__FB_A16                                    0x004c 0x0000 0x9 0x0
+#define IMX7ULP_PAD_PTC19__USB0_ID                                   0x004c 0x0338 0xa 0x3
+#define IMX7ULP_PAD_PTC19__USB1_PWR2                                 0x004c 0x0000 0xb 0x0
+#define IMX7ULP_PAD_PTC19__VIU_DE                                    0x004c 0x033c 0xc 0x3
 #define IMX7ULP_PAD_PTD0__PTD0                                       0x0080 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTD0__SDHC0_RESET_B                              0x0080 0x0000 0x8 0x0
 #define IMX7ULP_PAD_PTD1__PTD1                                       0x0084 0x0000 0x1 0x0
@@ -218,6 +225,7 @@
 #define IMX7ULP_PAD_PTE5__LPI2C5_SDA                                 0x0114 0x02c0 0x5 0x2
 #define IMX7ULP_PAD_PTE5__TPM5_CH0                                   0x0114 0x02c4 0x6 0x2
 #define IMX7ULP_PAD_PTE5__SDHC1_D2                                   0x0114 0x0000 0x8 0x0
+#define IMX7ULP_PAD_PTE5__VIU_DE                                     0x0114 0x033c 0xc 0x2
 #define IMX7ULP_PAD_PTE6__PTE6                                       0x0118 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTE6__FXIO1_D25                                  0x0118 0x0000 0x2 0x0
 #define IMX7ULP_PAD_PTE6__LPSPI2_SCK                                 0x0118 0x02ac 0x3 0x2
@@ -226,8 +234,10 @@
 #define IMX7ULP_PAD_PTE6__TPM7_CH3                                   0x0118 0x02e8 0x6 0x2
 #define IMX7ULP_PAD_PTE6__SDHC1_D4                                   0x0118 0x0000 0x8 0x0
 #define IMX7ULP_PAD_PTE6__FB_A17                                     0x0118 0x0000 0x9 0x0
+#define IMX7ULP_PAD_PTE6__USB0_OC                                    0x0118 0x0330 0xb 0x1
 #define IMX7ULP_PAD_PTE7__PTE7                                       0x011c 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTE7__TRACE_D7                                   0x011c 0x0000 0xa 0x0
+#define IMX7ULP_PAD_PTE7__USB0_PWR                                   0x011c 0x0000 0xb 0x0
 #define IMX7ULP_PAD_PTE7__VIU_FID                                    0x011c 0x0000 0xc 0x0
 #define IMX7ULP_PAD_PTE7__FXIO1_D24                                  0x011c 0x0000 0x2 0x0
 #define IMX7ULP_PAD_PTE7__LPSPI2_PCS0                                0x011c 0x029c 0x3 0x2
@@ -278,6 +288,7 @@
 #define IMX7ULP_PAD_PTE11__FB_A20                                    0x012c 0x0000 0x9 0x0
 #define IMX7ULP_PAD_PTE12__PTE12                                     0x0130 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTE12__TRACE_D2                                  0x0130 0x0000 0xa 0x0
+#define IMX7ULP_PAD_PTE12__USB1_OC2                                  0x0130 0x0334 0xb 0x2
 #define IMX7ULP_PAD_PTE12__VIU_D20                                   0x0130 0x0000 0xc 0x0
 #define IMX7ULP_PAD_PTE12__FXIO1_D19                                 0x0130 0x0000 0x2 0x0
 #define IMX7ULP_PAD_PTE12__LPSPI3_SIN                                0x0130 0x0324 0x3 0x2
@@ -288,6 +299,7 @@
 #define IMX7ULP_PAD_PTE12__FB_A21                                    0x0130 0x0000 0x9 0x0
 #define IMX7ULP_PAD_PTE13__PTE13                                     0x0134 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTE13__TRACE_D1                                  0x0134 0x0000 0xa 0x0
+#define IMX7ULP_PAD_PTE13__USB1_PWR2                                 0x0134 0x0000 0xb 0x0
 #define IMX7ULP_PAD_PTE13__VIU_D21                                   0x0134 0x0000 0xc 0x0
 #define IMX7ULP_PAD_PTE13__FXIO1_D18                                 0x0134 0x0000 0x2 0x0
 #define IMX7ULP_PAD_PTE13__LPSPI3_SOUT                               0x0134 0x0328 0x3 0x2
@@ -298,6 +310,7 @@
 #define IMX7ULP_PAD_PTE13__FB_A22                                    0x0134 0x0000 0x9 0x0
 #define IMX7ULP_PAD_PTE14__PTE14                                     0x0138 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTE14__TRACE_D0                                  0x0138 0x0000 0xa 0x0
+#define IMX7ULP_PAD_PTE14__USB0_OC                                   0x0138 0x0330 0xb 0x2
 #define IMX7ULP_PAD_PTE14__VIU_D22                                   0x0138 0x0000 0xc 0x0
 #define IMX7ULP_PAD_PTE14__FXIO1_D17                                 0x0138 0x0000 0x2 0x0
 #define IMX7ULP_PAD_PTE14__LPSPI3_SCK                                0x0138 0x0320 0x3 0x2
@@ -308,6 +321,7 @@
 #define IMX7ULP_PAD_PTE14__FB_A23                                    0x0138 0x0000 0x9 0x0
 #define IMX7ULP_PAD_PTE15__PTE15                                     0x013c 0x0000 0x1 0x0
 #define IMX7ULP_PAD_PTE15__TRACE_CLKOUT                              0x013c 0x0000 0xa 0x0
+#define IMX7ULP_PAD_PTE15__USB0_PWR                                  0x013c 0x0000 0xb 0x0
 #define IMX7ULP_PAD_PTE15__VIU_D23                                   0x013c 0x0000 0xc 0x0
 #define IMX7ULP_PAD_PTE15__FXIO1_D16                                 0x013c 0x0000 0x2 0x0
 #define IMX7ULP_PAD_PTE15__LPSPI3_PCS0                               0x013c 0x0310 0x3 0x2
@@ -315,7 +329,7 @@
 #define IMX7ULP_PAD_PTE15__TPM6_CH1                                  0x013c 0x02d4 0x6 0x2
 #define IMX7ULP_PAD_PTE15__FB_A24                                    0x013c 0x0000 0x9 0x0
 #define IMX7ULP_PAD_PTF0__PTF0                                       0x0180 0x0000 0x1 0x0
-#define IMX7ULP_PAD_PTF0__VIU_DE                                     0x0180 0x0000 0xc 0x0
+#define IMX7ULP_PAD_PTF0__VIU_DE                                     0x0180 0x033c 0xc 0x0
 #define IMX7ULP_PAD_PTF0__LPUART4_CTS_B                              0x0180 0x0244 0x4 0x3
 #define IMX7ULP_PAD_PTF0__LPI2C4_SCL                                 0x0180 0x0278 0x5 0x3
 #define IMX7ULP_PAD_PTF0__TPM4_CLKIN                                 0x0180 0x0298 0x6 0x3
-- 
2.7.4
