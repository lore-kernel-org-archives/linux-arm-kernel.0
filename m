From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 28 Oct 2014 11:44:55 -0700
Subject: [PATCH 2/2] MAINTAINERS: add entry for the GISB arbiter driver
In-Reply-To: <1414521895-12667-1-git-send-email-f.fainelli@gmail.com>
References: <1414521895-12667-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1414521895-12667-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GISB bus arbiter driver is relevant for BCM7xxx (brcmstb) platforms,
add an entry to cover this file.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 33a8b31e03f0..e9fe70cb525a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2100,6 +2100,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-bcm/*brcmstb*
 F:	arch/arm/boot/dts/bcm7*.dts*
+F:	drivers/bus/brcmstb_gisb.c
 
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Prashant Sreedharan <prashant@broadcom.com>
-- 
1.9.1
