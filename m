From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 12 Nov 2013 11:41:12 +0100
Subject: [PATCH] MAINTAINERS: Add maintainer for the ARM Ux500 clock driver
Message-ID: <1384252872-5717-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 284969f..1d0ae30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1296,6 +1296,14 @@ F:	drivers/rtc/rtc-ab8500.c
 F:	drivers/rtc/rtc-pl031.c
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
 
+ARM/Ux500 CLOCK FRAMEWORK SUPPORT
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+T:	git git://git.linaro.org/people/ulfh/clk.git
+S:	Maintained
+F:	drivers/clk/ux500/
+F:	include/linux/platform_data/clk-ux500.h
+
 ARM/VFP SUPPORT
 M:	Russell King <linux@arm.linux.org.uk>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.7.9.5
