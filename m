From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 29 Aug 2014 22:07:55 +0200
Subject: [PATCH] MAINTAINERS: update ARM pxa maintainers
Message-ID: <1409342875-31720-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change pxa active maintainers, and remove more busy people.
Remove Eric's tree as it is not accessible anymore.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 217dc54..76ee718 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7291,12 +7291,12 @@ F:	drivers/video/backlight/pwm_bl.c
 F:	include/linux/pwm_backlight.h
 
 PXA2xx/PXA3xx SUPPORT
-M:	Eric Miao <eric.y.miao@gmail.com>
-M:	Russell King <linux@arm.linux.org.uk>
 M:	Haojian Zhuang <haojian.zhuang@gmail.com>
+M:	Robert Jarzmik <robert.jarzmik@free.fr>
+M:	Daniel Mack <daniel@zonque.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://github.com/hzhuang1/linux.git
-T:	git git://git.linaro.org/people/ycmiao/pxa-linux.git
+T:	git git://github.com/rjarzmik/linux.git
 S:	Maintained
 F:	arch/arm/mach-pxa/
 F:	drivers/pcmcia/pxa2xx*
-- 
2.0.0.rc2
