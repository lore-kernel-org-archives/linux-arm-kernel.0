From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:47 +0100
Subject: [PATCH 34/69] clocksource/drivers/fsl-ftm: Add the COMPILE_TEST option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-34-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3457a86..7085eb7 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -245,7 +245,7 @@ config CLKSRC_SAMSUNG_PWM
 	  needed only on systems that do not have the Exynos MCT available.
 
 config FSL_FTM_TIMER
-	bool
+	bool "Freescale FlexTimer Module driver" if COMPILE_TEST
 	help
 	  Support for Freescale FlexTimer Module (FTM) timer.
 
-- 
1.9.1
