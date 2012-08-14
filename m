From: sourav.poddar@ti.com (Sourav Poddar)
Date: Tue, 14 Aug 2012 21:54:29 +0530
Subject: [PATCHv3 0/4] Add device tree data for omap5
Message-ID: <1344961473-13675-1-git-send-email-sourav.poddar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series add i2c support for omap5.
As well as enable I2C based devices like pressure and temperature
through device tree. Also add onchip keypad dts data.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Sourav Poddar (4):
  arm/dts: omap5-evm: Add I2C support
  arm/dts: omap5-evm: Add tmp102 sensor support
  arm/dts: omap5-evm: Add keypad data
  arm/dts: omap5-evm: Add bmp085 sensor support

v2->v3
- Rebased on 3.6-rc1
- Add comments for tmp102 and bmp085
 arch/arm/boot/dts/omap5-evm.dts |   32 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi    |   40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 0 deletions(-)
