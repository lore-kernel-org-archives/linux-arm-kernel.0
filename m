From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Nov 2015 15:25:15 -0800
Subject: [PATCH 1/2] MAINTAINERS: brcmstb: Include Broadcom internal
 mailing-list
In-Reply-To: <1447889116-19293-1-git-send-email-f.fainelli@gmail.com>
References: <1447889116-19293-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1447889116-19293-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include bcm-kernel-feedback-list for all brcmstb patch submission to be
both consistent with how other Broadcom ARM-based SoCs are handled, and
get internal Broadcom people to review these changes.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea1751283b49..08f9ed61412b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2356,6 +2356,7 @@ M:	Brian Norris <computersforpeace@gmail.com>
 M:	Gregory Fong <gregory.0xf0@gmail.com>
 M:	Florian Fainelli <f.fainelli@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	bcm-kernel-feedback-list at broadcom.com
 T:	git git://github.com/broadcom/stblinux.git
 S:	Maintained
 F:	arch/arm/mach-bcm/*brcmstb*
-- 
2.1.0
