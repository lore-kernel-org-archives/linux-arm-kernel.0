From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  9 Jan 2015 14:45:38 -0800
Subject: [PATCH 1/4] MAINTAINERS: move BCM63xx ARM-based SoCs git tree
In-Reply-To: <1420843541-5166-1-git-send-email-f.fainelli@gmail.com>
References: <1420843541-5166-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1420843541-5166-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Broadcom BCM63xx ARM-based SoCs git tree from
github.com/brcm/linux.git to github.com/Broadcom/arm-bcm63xx.git where
it now belongs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddb9ac8d32b3..ff73215cd165 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2124,7 +2124,7 @@ F:	arch/arm/boot/dts/bcm470*
 BROADCOM BCM63XX ARM ARCHITECTURE
 M:	Florian Fainelli <f.fainelli@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org
-T:	git git://git.github.com/brcm/linux.git
+T:	git git://git.github.com/broadcom/arm-bcm63xx.git
 S:	Maintained
 F:	arch/arm/mach-bcm/bcm63xx.c
 F:	arch/arm/include/debug/bcm63xx.S
-- 
2.1.0
