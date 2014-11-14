From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 14 Nov 2014 12:53:43 -0800
Subject: [PATCH 1/2 v2] MAINTAINERS: update brcmstb entries
In-Reply-To: <1415998424-20304-1-git-send-email-f.fainelli@gmail.com>
References: <1415998424-20304-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1415998424-20304-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Gregory Fong and myself as maintainers for the brcmstb platform
along with Brian Norris and Marc Carino.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
- do not remove Marc, add Gregory and myself

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea4d0058fd1b..530ac3cb1fea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2097,6 +2097,8 @@ F:	arch/arm/include/debug/bcm63xx.S
 BROADCOM BCM7XXX ARM ARCHITECTURE
 M:	Marc Carino <marc.ceeeee@gmail.com>
 M:	Brian Norris <computersforpeace@gmail.com>
+M:	Gregory Fong <gregory.0xf0@gmail.com>
+M:	Florian Fainelli <f.fainelli@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-bcm/*brcmstb*
-- 
1.9.1
