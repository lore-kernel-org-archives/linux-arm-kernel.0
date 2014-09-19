From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 19 Sep 2014 22:22:10 +0200
Subject: [PATCH] MAINTAINERS: update ARM pxa maintainers
In-Reply-To: <1409342875-31720-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Fri, 29 Aug 2014 22:07:55 +0200")
References: <1409342875-31720-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87tx43xswd.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I think I met the necessary number of acks. I amended the patch to reflect this,
attached to this mail.

Could you schedule this single patch for your maintainers branch (or for-next by
default) in arm-soc please ?

Cheers.

--
Robert

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-MAINTAINERS-update-ARM-pxa-maintainers.patch
Type: text/x-diff
Size: 1325 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140919/607fe573/attachment.bin>
-------------- next part --------------

--<8--
>From c4d1e8e185c76654452c5161c86f3cc34b3ba103 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Fri, 29 Aug 2014 22:07:55 +0200
Subject: [PATCH] MAINTAINERS: update ARM pxa maintainers

Change pxa active maintainers, and remove more busy people.
Remove Eric's tree as it is not accessible anymore.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Daniel Mack <zonque@gmail.com>
Acked-by: Eric Miao <eric.y.miao@gmail.com>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ff06de..d7ec0f6 100644
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
