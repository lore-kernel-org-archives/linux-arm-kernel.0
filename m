From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed,  5 Jun 2013 23:18:16 +0200
Subject: [PATCH 11/15] pwm: Remove superseded pwm-samsung-legacy driver
In-Reply-To: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1370467100-10820-12-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the now unused pwm-samsung-legacy driver, which was
replaced by new pwm-samsung driver.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pwm/Makefile             |   1 -
 drivers/pwm/pwm-samsung-legacy.c | 353 ---------------------------------------
 2 files changed, 354 deletions(-)
 delete mode 100644 drivers/pwm/pwm-samsung-legacy.c

diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 833c3ac..94ba21e 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -8,7 +8,6 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_PUV3)		+= pwm-puv3.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
-obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung-legacy.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
diff --git a/drivers/pwm/pwm-samsung-legacy.c b/drivers/pwm/pwm-samsung-legacy.c
deleted file mode 100644
index a0ece50..0000000
-- 
1.8.2.1
