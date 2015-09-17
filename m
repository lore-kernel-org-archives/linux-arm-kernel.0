From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 Sep 2015 14:45:57 +0100
Subject: [PATCH v2 7/7] MAINTAINERS: Add ST's Random Number Generator to the
 ST entry
In-Reply-To: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1442497557-9271-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd60784..b084d69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1502,6 +1502,7 @@ W:	http://www.stlinux.com
 S:	Maintained
 F:	arch/arm/mach-sti/
 F:	arch/arm/boot/dts/sti*
+F:	drivers/char/hw_random/st-rng.c
 F:	drivers/clocksource/arm_global_timer.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/media/rc/st_rc.c
-- 
1.9.1
