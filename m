From: sourav.poddar@ti.com (Sourav Poddar)
Date: Mon, 11 Mar 2013 19:14:46 +0530
Subject: [Resend/PATCH 0/5] omap4/5: i2c/spi: device tree data
Message-ID: <1363009486-19430-1-git-send-email-sourav.poddar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony/Benoit,

These patches had been sent couple of times before, but there were no comments on it.

If there are no comments, Can these be picked ? 

Cc: Andrew Morton <akpm@osdl.org>
 
The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:
  git at gitorious.org:linux-connectivity/linux-connectivity.git omap_i2c_spi_dts_data

Felipe Balbi (1):
      arm: dts: omap5: add SPI devices to OMAP5 DeviceTree file

Sourav Poddar (4):
      arm: dts: omap4-sdp: Add I2c pinctrl data
      arm: dts: omap5-evm: Add I2c pinctrl data
      arm: dts: omap4-panda: Add I2c pinctrl data
      arm: dts: omap5-evm: Add mcspi data

 arch/arm/boot/dts/omap4-panda.dts |   40 ++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts   |   40 ++++++++++++++
 arch/arm/boot/dts/omap5-evm.dts   |  108 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi      |   40 ++++++++++++++
 4 files changed, 228 insertions(+), 0 deletions(-)
