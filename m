From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 21 Mar 2012 10:27:47 +0100
Subject: [RFC][PATCH 4/7] ARM: OMAP4: cpuidle - fix static omap4_idle_data
 declaration
In-Reply-To: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1332322070-24577-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 0455858..254f97b 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -33,7 +33,7 @@ struct omap4_idle_statedata {
 
 #define OMAP4_NUM_STATES 3
 
-struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
+static struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
 static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
 
 /**
-- 
1.7.5.4
