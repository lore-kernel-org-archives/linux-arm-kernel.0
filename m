From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 16 Jun 2011 17:33:04 +0900
Subject: [PATCH] Samsung SoC ADC: register address definition for
	S5PV210/S5PC110/Exynos4
In-Reply-To: <1308213003-6526-2-git-send-email-myungjoo.ham@samsung.com>
References: <1308213003-6526-2-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1308213184-6607-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ADCMUX register is added.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/regs-adc.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/regs-adc.h b/arch/arm/plat-samsung/include/plat/regs-adc.h
index 7554c4f..035e8c3 100644
--- a/arch/arm/plat-samsung/include/plat/regs-adc.h
+++ b/arch/arm/plat-samsung/include/plat/regs-adc.h
@@ -21,6 +21,7 @@
 #define S3C2410_ADCDAT1	   S3C2410_ADCREG(0x10)
 #define S3C64XX_ADCUPDN		S3C2410_ADCREG(0x14)
 #define S3C64XX_ADCCLRINT	S3C2410_ADCREG(0x18)
+#define S5P_ADCMUX		S3C2410_ADCREG(0x1C)
 #define S3C64XX_ADCCLRINTPNDNUP	S3C2410_ADCREG(0x20)
 
 
-- 
1.7.4.1
