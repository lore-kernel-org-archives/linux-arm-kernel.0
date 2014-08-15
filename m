From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 14 Aug 2014 17:11:27 -0700
Subject: [PATCH v2 5/5] MAINTAINERS: add entry for the Broadcom BCM63xx ARM
 SoCs
In-Reply-To: <1408061487-20984-1-git-send-email-f.fainelli@gmail.com>
References: <1408061487-20984-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1408061487-20984-6-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a MAINTAINERS entry covering all the Broadcom BCM63xx ARM DSL SoCs
files along with the relevant git tree and mailing-list.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
- rebased against latest changes

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e2eb4c646e3..2075bb579853 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2013,6 +2013,14 @@ F:	arch/arm/mach-bcm/bcm_5301x.c
 F:	arch/arm/boot/dts/bcm5301x.dtsi
 F:	arch/arm/boot/dts/bcm470*
 
+BROADCOM BCM63XX ARM ARCHITECTURE
+M:	Florian Fainelli <f.fainelli@gmail.com>
+L:	linux-arm-kernel at lists.infradead.org
+T:	git git://git.github.com/broadcom/arm-bcm63xx
+S:	Maintained
+F:	arch/arm/mach-bcm/bcm63xx.c
+F:	arch/arm/include/debug/bcm63xx.S
+
 BROADCOM BCM7XXX ARM ARCHITECTURE
 M:	Marc Carino <marc.ceeeee@gmail.com>
 M:	Brian Norris <computersforpeace@gmail.com>
-- 
1.9.1
