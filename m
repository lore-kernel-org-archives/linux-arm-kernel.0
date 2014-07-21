From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 21 Jul 2014 14:08:06 -0700
Subject: [PATCH v8 11/11] MAINTAINERS: add entry for Broadcom ARM STB
 architecture
In-Reply-To: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
References: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1405976886-27807-12-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61a8f486306b..8e9cce53f618 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1969,6 +1969,15 @@ F:	arch/arm/mach-bcm/bcm_5301x.c
 F:	arch/arm/boot/dts/bcm5301x.dtsi
 F:	arch/arm/boot/dts/bcm470*
 
+BROADCOM BCM7XXX ARM ARCHITECTURE
+M:	Marc Carino <marc.ceeeee@gmail.com>
+M:	Brian Norris <computersforpeace@gmail.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+T:	git git://github.com/brcm/linux.git
+S:	Maintained
+F:	arch/arm/mach-bcm/*brcmstb*
+F:	arch/arm/boot/dts/bcm7*.dts*
+
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Nithin Nayak Sujir <nsujir@broadcom.com>
 M:	Michael Chan <mchan@broadcom.com>
-- 
1.9.1
