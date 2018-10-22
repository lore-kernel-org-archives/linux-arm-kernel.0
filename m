From: alex.gonzalez@digi.com (Alex Gonzalez)
Date: Mon, 22 Oct 2018 12:33:17 +0200
Subject: [PATCH 0/2] ARM: dts: ccimx6ulsbcpro: Add 10" AUO/Goodix LVDS panel
 accessory kit
Message-ID: <1540204399-12982-1-git-send-email-alex.gonzalez@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for a LVDS panel accessory kit consisting of:

* AU Optronics G101EVN010 10.1 inches TFT-LCD display
* Goodix GT911 capacitive touch controller

Alex Gonzalez (2):
  ARM: dts: ccimx6ulsbcpro: Add support for AUO G101EVN010 display
  ARM: dts: ccimx6ulsbcpro: Add support for Goodix touch controller

 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 44 +++++++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig        |  1 +
 2 files changed, 45 insertions(+)
