From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Wed, 25 Apr 2012 19:28:58 +0530
Subject: [PATCH-V5 1/3] ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC timer to
 prcm-common header
In-Reply-To: <1335362340-14960-1-git-send-email-hvaibhav@ti.com>
References: <1335362340-14960-1-git-send-email-hvaibhav@ti.com>
Message-ID: <1335362340-14960-2-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing idle_st bit for 32k-sync timer into the prcm-common
header file, required for hwmod data.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
NOTE: This patch is same as first version, without any code changes.

 arch/arm/mach-omap2/prcm-common.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 5aa5435..29955d5 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -177,6 +177,8 @@
 /* PM_WKST_WKUP, CM_IDLEST_WKUP shared bits */
 #define OMAP24XX_ST_GPIOS_SHIFT				2
 #define OMAP24XX_ST_GPIOS_MASK				(1 << 2)
+#define OMAP24XX_ST_32KSYNC_SHIFT			1
+#define OMAP24XX_ST_32KSYNC_MASK			(1 << 1)
 #define OMAP24XX_ST_GPT1_SHIFT				0
 #define OMAP24XX_ST_GPT1_MASK				(1 << 0)

@@ -307,6 +309,8 @@
 #define OMAP3430_ST_SR1_MASK				(1 << 6)
 #define OMAP3430_ST_GPIO1_SHIFT				3
 #define OMAP3430_ST_GPIO1_MASK				(1 << 3)
+#define OMAP3430_ST_32KSYNC_SHIFT			2
+#define OMAP3430_ST_32KSYNC_MASK			(1 << 2)
 #define OMAP3430_ST_GPT12_SHIFT				1
 #define OMAP3430_ST_GPT12_MASK				(1 << 1)
 #define OMAP3430_ST_GPT1_SHIFT				0
--
1.7.0.4
