From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 22 Jul 2010 18:29:23 +0200
Subject: [PATCH V2 4/6] mx35: add flexcan address
In-Reply-To: <1279816165-6542-1-git-send-email-mkl@pengutronix.de>
References: <1279816165-6542-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1279816165-6542-5-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx35.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index cda60c7..af3038c 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -60,6 +60,8 @@
 #define MX35_RTC_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xd8000)
 #define MX35_WDOG_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xdc000)
 #define MX35_PWM_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xe0000)
+#define MX35_CAN1_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xe4000)
+#define MX35_CAN2_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xe8000)
 #define MX35_RTIC_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xec000)
 #define MX35_OTG_BASE_ADDR		0x53ff4000
 
-- 
1.7.1
