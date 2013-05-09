From: b32955@freescale.com (Huang Shijie)
Date: Thu, 9 May 2013 11:28:58 +0800
Subject: [PATCH 0/5] add SPI/NOR for imx6q{dl}-sabreauto boards
Message-ID: <1368070143-1655-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch set add the SPI/NOR support for imx6q-sabreauto/imx6dl-sabreauto
boards.

Tested on both boards.

Huang Shijie (5):
  ARM: dts: imx6q: add a new device node for ecspi1
  ARM: dts: imx6dl: add a pinctrl for eCSPI1
  ARM: dts: imx6dl: add a gpio for hog
  ARM: dts: imx6q: add a gpio for hog
  ARM: dts: add SPI/NOR for mx6q{dl}-sabreauto boards

 arch/arm/boot/dts/imx6dl-sabreauto.dts   |    1 +
 arch/arm/boot/dts/imx6dl.dtsi            |   10 +++++++++
 arch/arm/boot/dts/imx6q-sabreauto.dts    |    1 +
 arch/arm/boot/dts/imx6q.dtsi             |   11 ++++++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |   32 ++++++++++++++++++++++++++++++
 5 files changed, 55 insertions(+), 0 deletions(-)
