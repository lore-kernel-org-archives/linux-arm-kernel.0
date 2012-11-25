From: tremyfr@yahoo.fr (Philippe Reynes)
Date: Sun, 25 Nov 2012 21:17:01 +0100
Subject: [PATCH 0/4] apf27: enable Ethernet PHY and add support of ds1374 rtc
Message-ID: <1353874625-14754-1-git-send-email-tremyfr@yahoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enable Ethernet PHY at startup, and add
the support of ds1374 rtc on armadeus apf27.

Philippe Reynes (4):
  apf27: enable Ethernet PHY
  ds1374: add support of device tree
  imx27-dt: configure i2c1 gpio on armadeus apf27
  apf27: add rtc ds1374 to the device tree

 arch/arm/boot/dts/imx27-apf27.dts |   10 ++++++++++
 arch/arm/mach-imx/imx27-dt.c      |   26 ++++++++++++++++++++++++++
 drivers/rtc/rtc-ds1374.c          |    8 ++++++++
 3 files changed, 44 insertions(+), 0 deletions(-)

-- 
1.7.4.4
