From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 14 Nov 2014 12:53:44 -0800
Subject: [PATCH 2/2 v2] MAINTAINERS: add entry for the GISB arbiter driver
In-Reply-To: <1415998424-20304-1-git-send-email-f.fainelli@gmail.com>
References: <1415998424-20304-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1415998424-20304-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GISB bus arbiter driver is relevant for BCM7xxx (brcmstb) platforms,
add an entry to cover this file.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 530ac3cb1fea..7081ec6a294d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2103,6 +2103,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-bcm/*brcmstb*
 F:	arch/arm/boot/dts/bcm7*.dts*
+F:	drivers/bus/brcmstb_gisb.c
 
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Prashant Sreedharan <prashant@broadcom.com>
-- 
1.9.1
