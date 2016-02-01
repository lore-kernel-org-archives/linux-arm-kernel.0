From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 31 Jan 2016 17:41:13 -0800
Subject: [PATCH] MAINTAINERS: ARM: BCM63xx: Update git and mailing-lists
Message-ID: <1454290873-29931-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm-bcm63xx.git has not been used for development, instead, all patches
have been added to stblinux.git, so reflect that. While at it, add
bcm-kernel-feedback-list at broadcom.com as a secondary list to include
submissions, and finally update LAKML to reflect that it is moderated.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30aca4aa5467..7f579c835476 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2383,8 +2383,9 @@ F:	arch/arm/boot/dts/bcm470*
 
 BROADCOM BCM63XX ARM ARCHITECTURE
 M:	Florian Fainelli <f.fainelli@gmail.com>
-L:	linux-arm-kernel at lists.infradead.org
-T:	git git://github.com/broadcom/arm-bcm63xx.git
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	bcm-kernel-feedback-list at broadcom.com
+T:	git git://github.com/broadcom/stblinux.git
 S:	Maintained
 F:	arch/arm/mach-bcm/bcm63xx.c
 F:	arch/arm/include/debug/bcm63xx.S
-- 
2.5.0
