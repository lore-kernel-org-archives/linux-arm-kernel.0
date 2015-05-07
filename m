From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  7 May 2015 14:38:41 +0100
Subject: [PATCH 09/12] MAINTAINERS: Add the LPC Clocksource to STi maintained
 driver list
In-Reply-To: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1431005924-21777-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2bc71e7..af9e952 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1454,6 +1454,7 @@ S:	Maintained
 F:	arch/arm/mach-sti/
 F:	arch/arm/boot/dts/sti*
 F:	drivers/clocksource/arm_global_timer.c
+F:	drivers/clocksource/clksrc_st_lpc.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/mmc/host/sdhci-st.c
-- 
1.9.1
