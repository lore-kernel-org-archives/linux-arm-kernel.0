From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 27 Mar 2014 16:37:45 +0530
Subject: [PATCH v2 2/7] clk: exynos5420: Add more clock IDs
In-Reply-To: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
References: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1395918470-16374-3-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <rahul.sharma@samsung.com>

Add more clock IDs to be used in DT bindings for Exynos5420.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 include/dt-bindings/clock/exynos5420.h |   62 ++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 5eefd88..e921913 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -58,6 +58,16 @@
 #define CLK_SCLK_GSCL_WA	156
 #define CLK_SCLK_GSCL_WB	157
 #define CLK_SCLK_HDMIPHY	158
+#define CLK_SCLK_MPHY_REFCLK	159
+#define CLK_SCLK_SPI0_ISP	160
+#define CLK_SCLK_SPI1_ISP	161
+#define CLK_SCLK_UART_ISP	162
+#define CLK_SCLK_ISP_SENSOR0	163
+#define CLK_SCLK_ISP_SENSOR1	164
+#define CLK_SCLK_ISP_SENSOR2	165
+#define CLK_SCLK_PWM_ISP	166
+#define CLK_SCLK_HSIC_12M	167
+#define CLK_SCLK_MPHY_IXTAL24	168
 
 /* gate clocks */
 #define CLK_ACLK66_PERIC	256
@@ -123,6 +133,7 @@
 #define CLK_USBH20		365
 #define CLK_USBD300		366
 #define CLK_USBD301		367
+#define CLK_PCLK200_FSYS	370
 #define CLK_ACLK400_MSCL	380
 #define CLK_MSCL0		381
 #define CLK_MSCL1		382
@@ -141,6 +152,8 @@
 #define CLK_ACLK300_DISP1	420
 #define CLK_FIMD1		421
 #define CLK_SMMU_FIMD1		422
+#define CLK_SMMU_FIMD1M1	423
+#define CLK_ACLK400_DISP1	424
 #define CLK_ACLK166		430
 #define CLK_MIXER		431
 #define CLK_ACLK266		440
@@ -172,12 +185,57 @@
 #define CLK_SMMU_FIMCL1		493
 #define CLK_SMMU_FIMCL3		494
 #define CLK_FIMC_LITE3		495
-#define CLK_ACLK_G3D		500
-#define CLK_G3D			501
+#define CLK_G3D			500
 #define CLK_SMMU_MIXER		502
+#define CLK_PCLK_TZPC10		503
+#define CLK_PCLK_TZPC11		504
+#define CLK_PCLK_MC		505
+#define CLK_PCLK_TOP_RTC	506
+#define CLK_SMMU_JPEG2		507
+#define CLK_PCLK_ROTATOR	508
+#define CLK_SMMU_RTIC		509
+#define CLK_PCLK_G2D		510
+#define CLK_ACLK_SMMU_G2D	511
+#define CLK_SMMU_G2D		512
+#define CLK_ACLK_SMMU_MDMA0	513
+#define CLK_SMMU_MDMA0		514
+#define CLK_ACLK_SMMU_SSS	515
+#define CLK_SMMU_SSS		516
+#define CLK_SMMU_SLIM_SSS	517
+#define CLK_ACLK_SMMU_SLIM_SSS	518
+#define CLK_ACLK266_ISP		519
+#define CLK_ACLK400_ISP		520
+#define CLK_ACLK333_432_ISP0	521
+#define CLK_ACLK333_432_ISP	522
+#define CLK_ACLK_SMMU_MIXER	523
+#define CLK_PCLK_HDMIPHY	524
+#define CLK_PCLK_GSCL0		525
+#define CLK_PCLK_GSCL1		526
+#define CLK_PCLK_FIMC_3AA	527
+#define CLK_ACLK_FIMC_LITE0	528
+#define CLK_ACLK_FIMC_LITE1	529
+#define CLK_PCLK_FIMC_LITE0	530
+#define CLK_PCLK_FIMC_LITE1	531
+#define CLK_PCLK_FIMC_LITE3	532
+#define CLK_PCLK_MSCL0		533
+#define CLK_PCLK_MSCL1		534
+#define CLK_PCLK_MSCL2		535
+#define CLK_PCLK_MFC		536
 
 /* mux clocks */
 #define CLK_MOUT_HDMI		640
+#define CLK_MOUT_FIMD1			641
+#define CLK_MOUT_MAUDIO0		642
+#define CLK_MOUT_SPI0			643
+#define CLK_MOUT_SPI1			644
+#define CLK_MOUT_SPI2			645
+#define CLK_MOUT_SW_ACLK333		646
+#define CLK_MOUT_USER_ACLK333		647
+#define CLK_MOUT_SW_ACLK300_GSCL	648
+#define CLK_MOUT_USER_ACLK300_GSCL	649
+#define CLK_MOUT_SW_ACLK333_432_GSCL	650
+#define CLK_MOUT_USER_ACLK333_432_GSCL	651
+#define CLK_MOUT_G3D			652
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
-- 
1.7.9.5
