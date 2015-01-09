From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  9 Jan 2015 14:45:40 -0800
Subject: [PATCH 3/4] MAINTAINERS: add a git entry for BCM7xxx ARM-based SoCs
In-Reply-To: <1420843541-5166-1-git-send-email-f.fainelli@gmail.com>
References: <1420843541-5166-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1420843541-5166-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use github.com/Broadcom/stblinux.git as our default development tree for
Broadcom BCM7xxx ARM-based SoCs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a8f3459f9c2..18a199638105 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2141,6 +2141,7 @@ M:	Brian Norris <computersforpeace@gmail.com>
 M:	Gregory Fong <gregory.0xf0@gmail.com>
 M:	Florian Fainelli <f.fainelli@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+T:	git git://git.github.com/broadcom/stblinux.git
 S:	Maintained
 F:	arch/arm/mach-bcm/*brcmstb*
 F:	arch/arm/boot/dts/bcm7*.dts*
-- 
2.1.0
