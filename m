From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 6 Mar 2014 09:45:59 -0800
Subject: [PATCH 6/6] MAINTAINERS: add entry for the Broadcom BCM63xx ARM SoCs
In-Reply-To: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
References: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1394127959-3159-7-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a MAINTAINERS entry covering all the Broadcom BCM63xx ARM DSL SoCs
files along with the relevant git tree and mailing-list.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1297ff255e1..628cfe1c6daa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1882,6 +1882,16 @@ F:	arch/arm/boot/dts/bcm2835*
 F:	arch/arm/configs/bcm2835_defconfig
 F:	drivers/*/*bcm2835*
 
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
1.8.3.2
