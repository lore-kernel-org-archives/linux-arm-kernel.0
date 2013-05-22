From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 May 2013 15:22:57 +0100
Subject: [PATCH 3/7] ARM: ux500: Standardise Pinctrl compatible string for
 Nomadik based platforms
In-Reply-To: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
References: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1369232581-18923-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-nomadik/cpu-8815.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 59f6ff5..316fe82 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -288,7 +288,7 @@ static struct of_dev_auxdata cpu8815_auxdata_lookup[] __initdata = {
 		"gpio.2", NULL),
 	OF_DEV_AUXDATA("st,nomadik-gpio", NOMADIK_GPIO3_BASE,
 		"gpio.3", NULL),
-	OF_DEV_AUXDATA("stericsson,nmk-pinctrl-stn8815", 0,
+	OF_DEV_AUXDATA("stericsson,stn8815-pinctrl", 0,
 		"pinctrl-stn8815", NULL),
 	OF_DEV_AUXDATA("arm,primecell", NOMADIK_UART0_BASE,
 		"uart0", NULL),
-- 
1.7.10.4
