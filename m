From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 28 Oct 2014 11:44:54 -0700
Subject: [PATCH 1/2] MAINTAINERS: update brcmstb entries
In-Reply-To: <1414521895-12667-1-git-send-email-f.fainelli@gmail.com>
References: <1414521895-12667-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1414521895-12667-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove Marc Carino from the brcmstb maintainers list and add Gregory
Fong and myself as new maintainers for the brcmstb platform.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dab92a78d1d5..33a8b31e03f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2093,8 +2093,9 @@ F:	arch/arm/mach-bcm/bcm63xx.c
 F:	arch/arm/include/debug/bcm63xx.S
 
 BROADCOM BCM7XXX ARM ARCHITECTURE
-M:	Marc Carino <marc.ceeeee@gmail.com>
 M:	Brian Norris <computersforpeace@gmail.com>
+M:	Gregory Fong <gregory.0xf0@gmail.com>
+M:	Florian Fainelli <f.fainelli@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-bcm/*brcmstb*
-- 
1.9.1
