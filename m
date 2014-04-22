From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 21 Apr 2014 18:39:18 -0700
Subject: [PATCH RESEND 5/5] MAINTAINERS: add entry for the Broadcom BCM63xx
 ARM SoCs
In-Reply-To: <1398130758-19456-1-git-send-email-f.fainelli@gmail.com>
References: <1398130758-19456-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1398130758-19456-6-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a MAINTAINERS entry covering all the Broadcom BCM63xx ARM DSL SoCs
files along with the relevant git tree and mailing-list.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e67ea2442041..135060fcf599 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1916,6 +1916,7 @@ F:	arch/arm/boot/dts/bcm2835*
 F:	arch/arm/configs/bcm2835_defconfig
 F:	drivers/*/*bcm2835*
 
+
 BROADCOM BCM5301X ARM ARCHICTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 L:	linux-arm-kernel at lists.infradead.org
@@ -1924,6 +1925,16 @@ F:	arch/arm/mach-bcm/bcm_5301x.c
 F:	arch/arm/boot/dts/bcm5301x.dtsi
 F:	arch/arm/boot/dts/bcm470*
 
+BROADCOM BCM63XX ARM ARCHITECTURE
+M:	Florian Fainelli <f.fainelli@gmail.com>
+L:	linux-arm-kernel at lists.infradead.org
+T:	git git://git.github.com/broadcom/arm-bcm63xx
+S:	Maintained
+F:	arch/arm/mach-bcm/board_bcm63xx.c
+F:	arch/arm/mach-bcm/bcm63xx.h
+F:	arch/arm/include/debug/bcm63xxx.S
+F:	arch/arm/configs/bcm_defconfig
+
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Nithin Nayak Sujir <nsujir@broadcom.com>
 M:	Michael Chan <mchan@broadcom.com>
-- 
1.9.1
