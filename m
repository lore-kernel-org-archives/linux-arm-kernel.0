From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 7 Jan 2012 13:55:41 +0800
Subject: linux-next: net/smsc911x compile error on next-20120106
Message-ID: <CAAQ0ZWSRzUM2rdhfWDqang6Baat6x-gEso5hQGEkbOqFjM-sMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen, David,

I just ran into the following compile error when building
next-20120106 with imx_v6_v7_defconfig.

  CC      drivers/net/ethernet/smsc/smsc911x.o
drivers/net/ethernet/smsc/smsc911x.c: In function
?smsc911x_phy_disable_energy_detect?:
drivers/net/ethernet/smsc/smsc911x.c:1329:32: error:
?MII_LAN83C185_CTRL_STATUS? undeclared (first use in this function)
drivers/net/ethernet/smsc/smsc911x.c:1329:32: note: each undeclared
identifier is reported only once for each function it appears in
drivers/net/ethernet/smsc/smsc911x.c:1340:12: error:
?MII_LAN83C185_EDPWRDOWN? undeclared (first use in this function)
drivers/net/ethernet/smsc/smsc911x.c:1341:13: error:
?MII_LAN83C185_ENERGYON? undeclared (first use in this function)
drivers/net/ethernet/smsc/smsc911x.c: In function
?smsc911x_phy_enable_energy_detect?:
drivers/net/ethernet/smsc/smsc911x.c:1364:32: error:
?MII_LAN83C185_CTRL_STATUS? undeclared (first use in this function)
drivers/net/ethernet/smsc/smsc911x.c:1372:13: error:
?MII_LAN83C185_EDPWRDOWN? undeclared (first use in this function)

-- 
Regards,
Shawn
