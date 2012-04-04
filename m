From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  4 Apr 2012 22:12:49 +0200
Subject: [PATCH 15/17][V2] ARM: OMAP3: set omap3_idle_data as static
In-Reply-To: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1333570371-1389-16-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 35a1471..f54e6ae 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -46,7 +46,7 @@ struct omap3_idle_statedata {
 
 #define OMAP3_NUM_STATES 7
 
-struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES] = {
+static struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES] = {
 	{
 		.mpu_state = PWRDM_POWER_ON,
 		.core_state = PWRDM_POWER_ON,
-- 
1.7.5.4
