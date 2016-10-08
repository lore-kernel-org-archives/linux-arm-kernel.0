From: peter.griffin@linaro.org (Peter Griffin)
Date: Sat,  8 Oct 2016 13:52:29 +0100
Subject: [PATCH v10 07/11] MAINTAINERS: Add FDMA driver files to STi section.
In-Reply-To: <1475931154-1021-1-git-send-email-peter.griffin@linaro.org>
References: <1475931154-1021-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1475931154-1021-8-git-send-email-peter.griffin@linaro.org>
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
index 9924036..f71a1d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1749,6 +1749,7 @@ F:	drivers/char/hw_random/st-rng.c
 F:	drivers/clocksource/arm_global_timer.c
 F:	drivers/clocksource/clksrc_st_lpc.c
 F:	drivers/cpufreq/sti-cpufreq.c
+F:	drivers/dma/st_fdma*
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/media/platform/sti/c8sectpfe/
-- 
1.9.1
