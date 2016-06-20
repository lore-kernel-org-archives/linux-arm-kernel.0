From: jon.mason@broadcom.com (Jon Mason)
Date: Mon, 20 Jun 2016 17:07:36 -0400
Subject: [PATCH 3/4] MAINTAINERS: Update BCM63XX entry
In-Reply-To: <1466456857-11969-1-git-send-email-jon.mason@broadcom.com>
References: <1466456857-11969-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1466456857-11969-4-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are more files being supported by the BCM63XX than simply
"arch/arm/mach-bcm/bcm63xx.c" and "arch/arm/include/debug/bcm63xx.S".
Add a regex of "bcm63xx" to catch all the other files that are out
there.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81be402..28a35f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2523,8 +2523,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	bcm-kernel-feedback-list at broadcom.com
 T:	git git://github.com/broadcom/stblinux.git
 S:	Maintained
-F:	arch/arm/mach-bcm/bcm63xx.c
-F:	arch/arm/include/debug/bcm63xx.S
+N:	bcm63xx
 
 BROADCOM BCM63XX/BCM33XX UDC DRIVER
 M:	Kevin Cernekee <cernekee@gmail.com>
-- 
1.9.1
