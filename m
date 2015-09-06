From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Sun,  6 Sep 2015 22:16:02 +0200
Subject: [PATCH 0/4] ARM: multi_v7_defconfig: Improve rockchip support
Message-ID: <1441570566-14001-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Enable options to provide more complete support for Rockchip boards
including: support for the common act8846 PMIC, I2C, SPI, PMW, Thermal
driver, HDMI video output and USB 2.


Sjoerd Simons (4):
  ARM: multi_v7_defconfig: Enable common Rockchip devices/busses
  ARM: multi_v7_defconfig: Enable ACT8865 PMIC driver
  ARM: multi_v7_defconfig: Enable Rockchip display support
  ARM: multi_v7_defconfig: Enable DW USB2 support and rockchip phy

 arch/arm/configs/multi_v7_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.5.1
