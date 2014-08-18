From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 18 Aug 2014 12:24:59 -0700
Subject: [PATCH v3 5/5] MAINTAINERS: add entry for the Broadcom BCM63xx ARM
 SoCs
In-Reply-To: <1408389899-1022-1-git-send-email-f.fainelli@gmail.com>
References: <1408389899-1022-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1408389899-1022-6-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a MAINTAINERS entry covering all the Broadcom BCM63xx ARM DSL SoCs
files along with the relevant git tree and mailing-list.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2 and v3:
- rebased against latest changes

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aefa94841ff3..1806edcb91b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2021,6 +2021,14 @@ F:	arch/arm/mach-bcm/bcm_5301x.c
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
