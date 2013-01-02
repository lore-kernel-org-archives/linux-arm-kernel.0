From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:38 -0800
Subject: [PATCH 01/26] gpio: samsung: remove inclusion <mach/regs-clock.h>
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The <mach/regs-clock.h> is not needed for gpio-samsung.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/gpio/gpio-samsung.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 01f7fe9..9070f86 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -32,7 +32,6 @@
 
 #include <mach/hardware.h>
 #include <mach/map.h>
-#include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
 
 #include <plat/cpu.h>
-- 
1.7.10.4
