From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  8 Aug 2017 15:15:39 +0800
Subject: [PATCH v3 1/9] clk: rockchip: add more clk ids for rv1108
In-Reply-To: <1502176547-30817-1-git-send-email-zhangqing@rock-chips.com>
References: <1502176547-30817-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1502176547-30817-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add new clk ids.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/clock/rv1108-cru.h | 93 +++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/rv1108-cru.h b/include/dt-bindings/clock/rv1108-cru.h
index ae26f8105914..fe013cf51e2b 100644
--- a/include/dt-bindings/clock/rv1108-cru.h
+++ b/include/dt-bindings/clock/rv1108-cru.h
@@ -43,12 +43,73 @@
 #define SCLK_SDMMC_SAMPLE		84
 #define SCLK_SDIO_SAMPLE		85
 #define SCLK_EMMC_SAMPLE		86
+#define SCLK_VENC_CORE			87
+#define SCLK_HEVC_CORE			88
+#define SCLK_HEVC_CABAC			89
+#define SCLK_PWM0_PMU			90
+#define SCLK_I2C0_PMU			91
+#define SCLK_WIFI			92
+#define SCLK_CIFOUT			93
+#define SCLK_MIPI_CSI_OUT		94
+#define SCLK_CIF0			95
+#define SCLK_CIF1			96
+#define SCLK_CIF2			97
+#define SCLK_CIF3			98
+#define SCLK_DSP			99
+#define SCLK_DSP_IOP			100
+#define SCLK_DSP_EPP			101
+#define SCLK_DSP_EDP			102
+#define SCLK_DSP_EDAP			103
+#define SCLK_CVBS_HOST			104
+#define SCLK_HDMI_SFR			105
+#define SCLK_HDMI_CEC			106
+#define SCLK_CRYPTO			107
+#define SCLK_SPI			108
+#define SCLK_SARADC			109
+#define SCLK_TSADC			110
+#define SCLK_MACPHY_PRE			111
+#define SCLK_MACPHY			112
+#define SCLK_MACPHY_RX			113
+#define SCLK_MAC_REF			114
+#define SCLK_MAC_REFOUT			115
+#define SCLK_DSP_PFM			116
+#define SCLK_RGA			117
+#define SCLK_I2C1			118
+#define SCLK_I2C2			119
+#define SCLK_I2C3			120
+#define SCLK_PWM			121
+#define SCLK_ISP			122
+#define SCLK_USBPHY			123
+#define SCLK_I2S0_SRC			124
+#define SCLK_I2S1_SRC			125
+#define SCLK_I2S2_SRC			126
+#define SCLK_UART0_SRC			127
+#define SCLK_UART1_SRC			128
+#define SCLK_UART2_SRC			129
+
+#define DCLK_VOP_SRC			185
+#define DCLK_HDMIPHY			186
+#define DCLK_VOP			187
 
 /* aclk gates */
 #define ACLK_DMAC			192
 #define ACLK_PRE			193
 #define ACLK_CORE			194
 #define ACLK_ENMCORE			195
+#define ACLK_RKVENC			196
+#define ACLK_RKVDEC			197
+#define ACLK_VPU			198
+#define ACLK_CIF0			199
+#define ACLK_VIO0			200
+#define ACLK_VIO1			201
+#define ACLK_VOP			202
+#define ACLK_IEP			203
+#define ACLK_RGA			204
+#define ACLK_ISP			205
+#define ACLK_CIF1			206
+#define ACLK_CIF2			207
+#define ACLK_CIF3			208
+#define ACLK_PERI			209
 
 /* pclk gates */
 #define PCLK_GPIO1			256
@@ -67,6 +128,19 @@
 #define PCLK_PWM			269
 #define PCLK_TIMER			270
 #define PCLK_PERI			271
+#define PCLK_GPIO0_PMU			272
+#define PCLK_I2C0_PMU			273
+#define PCLK_PWM0_PMU			274
+#define PCLK_ISP			275
+#define PCLK_VIO			276
+#define PCLK_MIPI_DSI			277
+#define PCLK_HDMI_CTRL			278
+#define PCLK_SARADC			279
+#define PCLK_DSP_CFG			280
+#define PCLK_BUS			281
+#define PCLK_EFUSE0			282
+#define PCLK_EFUSE1			283
+#define PCLK_WDT			284
 
 /* hclk gates */
 #define HCLK_I2S0_8CH			320
@@ -78,8 +152,25 @@
 #define HCLK_EMMC			326
 #define HCLK_PERI			327
 #define HCLK_SFC			328
+#define HCLK_RKVENC			329
+#define HCLK_RKVDEC			330
+#define HCLK_CIF0			331
+#define HCLK_VIO			332
+#define HCLK_VOP			333
+#define HCLK_IEP			334
+#define HCLK_RGA			335
+#define HCLK_ISP			336
+#define HCLK_CRYPTO_MST			337
+#define HCLK_CRYPTO_SLV			338
+#define HCLK_HOST0			339
+#define HCLK_OTG			340
+#define HCLK_CIF1			341
+#define HCLK_CIF2			342
+#define HCLK_CIF3			343
+#define HCLK_BUS			344
+#define HCLK_VPU			345
 
-#define CLK_NR_CLKS			(HCLK_SFC + 1)
+#define CLK_NR_CLKS			(HCLK_VPU + 1)
 
 /* reset id */
 #define SRST_CORE_PO_AD		0
-- 
1.9.1
