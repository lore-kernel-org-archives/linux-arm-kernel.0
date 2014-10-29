From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Wed, 29 Oct 2014 09:44:21 +0000
Subject: [PATCH v2] MAINTAINERS: drop list entry for davinci
Message-ID: <1414575861-3906-1-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As davinci-linux-open-source at linux.davincidsp.com is now
shut and no more maintained by TI, drop this entry from
DAVINCI MACHINE SUPPORT and DAVINCI SERIES MEDIA DRIVER.

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: arm at kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 Changes for v2:
 1: Restored link for patchwork.

 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dab92a7..ca86fd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8479,7 +8479,6 @@ F:	arch/arm/mach-s3c24xx/bast-irq.c
 TI DAVINCI MACHINE SUPPORT
 M:	Sekhar Nori <nsekhar@ti.com>
 M:	Kevin Hilman <khilman@deeprootsystems.com>
-L:	davinci-linux-open-source at linux.davincidsp.com (moderated for non-subscribers)
 T:	git git://gitorious.org/linux-davinci/linux-davinci.git
 Q:	http://patchwork.kernel.org/project/linux-davinci/list/
 S:	Supported
@@ -8489,7 +8488,6 @@ F:	drivers/i2c/busses/i2c-davinci.c
 TI DAVINCI SERIES MEDIA DRIVER
 M:	Lad, Prabhakar <prabhakar.csengg@gmail.com>
 L:	linux-media at vger.kernel.org
-L:	davinci-linux-open-source at linux.davincidsp.com (moderated for non-subscribers)
 W:	http://linuxtv.org/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git
-- 
1.9.1
