From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  5 Jul 2016 16:32:00 -0700
Subject: [PATCH] MAINTAINERS: Change L to M for Broadcom ARM SoC entries
Message-ID: <1467761520-23796-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcm-kernel-feedback-list at broadcom.com is a Broadcom internaly
mailing-list for which no external subscribers are allowed for now, so
update the different entries from L to M to reflect that.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Olof Johansson <olof@lixom.net>
Suggested-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
I am going to send this as a pull request since we have other
changes to the MAINTAINERS file, just posting it publicly before
the actual pull request.

 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b673a000e715..a5130c5f9f75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2478,7 +2478,7 @@ BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITECTURE
 M:	Florian Fainelli <f.fainelli@gmail.com>
 M:	Ray Jui <rjui@broadcom.com>
 M:	Scott Branden <sbranden@broadcom.com>
-L:	bcm-kernel-feedback-list at broadcom.com
+M:	bcm-kernel-feedback-list at broadcom.com
 T:	git git://github.com/broadcom/mach-bcm
 S:	Maintained
 F:	arch/arm/mach-bcm/
@@ -2522,7 +2522,7 @@ F:	arch/arm/boot/dts/bcm470*
 BROADCOM BCM63XX ARM ARCHITECTURE
 M:	Florian Fainelli <f.fainelli@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-L:	bcm-kernel-feedback-list at broadcom.com
+M:	bcm-kernel-feedback-list at broadcom.com
 T:	git git://github.com/broadcom/stblinux.git
 S:	Maintained
 F:	arch/arm/mach-bcm/bcm63xx.c
@@ -2539,7 +2539,7 @@ M:	Brian Norris <computersforpeace@gmail.com>
 M:	Gregory Fong <gregory.0xf0@gmail.com>
 M:	Florian Fainelli <f.fainelli@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-L:	bcm-kernel-feedback-list at broadcom.com
+M:	bcm-kernel-feedback-list at broadcom.com
 T:	git git://github.com/broadcom/stblinux.git
 S:	Maintained
 F:	arch/arm/mach-bcm/*brcmstb*
@@ -2598,7 +2598,7 @@ M:	Ray Jui <rjui@broadcom.com>
 M:	Scott Branden <sbranden@broadcom.com>
 M:	Jon Mason <jonmason@broadcom.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-L:	bcm-kernel-feedback-list at broadcom.com
+M:	bcm-kernel-feedback-list at broadcom.com
 T:	git git://github.com/broadcom/cygnus-linux.git
 S:	Maintained
 N:	iproc
-- 
2.7.4
