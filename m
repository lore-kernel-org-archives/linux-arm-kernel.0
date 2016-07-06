From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  6 Jul 2016 09:54:25 +0100
Subject: [PATCH v6 07/18] MAINTAINERS: Add FDMA driver files to STi section.
In-Reply-To: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
References: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1467795276-21725-8-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the FDMA driver files to the STi
section of the maintainers file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7af90e9..4de96d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1703,6 +1703,7 @@ F:	drivers/char/hw_random/st-rng.c
 F:	drivers/clocksource/arm_global_timer.c
 F:	drivers/clocksource/clksrc_st_lpc.c
 F:	drivers/cpufreq/sti-cpufreq.c
+F:	drivers/dma/st_fdma*
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/media/platform/sti/c8sectpfe/
-- 
1.9.1
