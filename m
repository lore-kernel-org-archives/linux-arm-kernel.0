From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Oct 2011 22:19:02 +0200
Subject: [PATCH] ARM: mark empty gpio.h files empty
Message-ID: <1319833142-4764-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is generally a better idea to make intentionally empty files
contain the human-readable /* empty */ comment, also it makes
the files play nice with "make distclean".

Reported-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-lpc32xx/include/mach/gpio.h |    1 +
 arch/arm/mach-tegra/include/mach/gpio.h   |    1 +
 arch/arm/mach-u300/include/mach/gpio.h    |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/include/mach/gpio.h b/arch/arm/mach-lpc32xx/include/mach/gpio.h
index e69de29..40a8c17 100644
--- a/arch/arm/mach-lpc32xx/include/mach/gpio.h
+++ b/arch/arm/mach-lpc32xx/include/mach/gpio.h
@@ -0,0 +1 @@
+/* empty */
diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
index e69de29..40a8c17 100644
--- a/arch/arm/mach-tegra/include/mach/gpio.h
+++ b/arch/arm/mach-tegra/include/mach/gpio.h
@@ -0,0 +1 @@
+/* empty */
diff --git a/arch/arm/mach-u300/include/mach/gpio.h b/arch/arm/mach-u300/include/mach/gpio.h
index e69de29..40a8c17 100644
--- a/arch/arm/mach-u300/include/mach/gpio.h
+++ b/arch/arm/mach-u300/include/mach/gpio.h
@@ -0,0 +1 @@
+/* empty */
-- 
1.7.3.2
