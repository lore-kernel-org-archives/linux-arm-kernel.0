From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 30 Sep 2014 10:32:58 +0200
Subject: [PATCH] MAINTAINERS: CNS3xxx and IXP4xx update.
Message-ID: <m3tx3pa4p1.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm told Anton Vorontsov can't maintain Cavium Econa CNS3xxx support
anymore. Perhaps I can.

Also changing my email contact address for IXP4xx.

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -861,10 +861,9 @@ S:	Maintained
 F:	arch/arm/mach-highbank/
 
 ARM/CAVIUM NETWORKS CNS3XXX MACHINE SUPPORT
-M:	Anton Vorontsov <anton@enomsg.org>
+M:	Krzysztof Halasa <khalasa@piap.pl>
 S:	Maintained
 F:	arch/arm/mach-cns3xxx/
-T:	git git://git.infradead.org/users/cbou/linux-cns3xxx.git
 
 ARM/CIRRUS LOGIC CLPS711X ARM ARCHITECTURE
 M:	Alexander Shiyan <shc_work@mail.ru>
@@ -1053,7 +1052,7 @@ S:	Maintained
 
 ARM/INTEL IXP4XX ARM ARCHITECTURE
 M:	Imre Kaloz <kaloz@openwrt.org>
-M:	Krzysztof Halasa <khc@pm.waw.pl>
+M:	Krzysztof Halasa <khalasa@piap.pl>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-ixp4xx/
@@ -4769,7 +4768,7 @@ S:	Odd fixes
 F:	drivers/dma/iop-adma.c
 
 INTEL IXP4XX QMGR, NPE, ETHERNET and HSS SUPPORT
-M:	Krzysztof Halasa <khc@pm.waw.pl>
+M:	Krzysztof Halasa <khalasa@piap.pl>
 S:	Maintained
 F:	arch/arm/mach-ixp4xx/include/mach/qmgr.h
 F:	arch/arm/mach-ixp4xx/include/mach/npe.h
