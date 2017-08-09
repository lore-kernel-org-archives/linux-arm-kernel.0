From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  9 Aug 2017 14:30:41 +0800
Subject: [PATCH 00/10] Update arm64 ZTE zx296718 device trees
Message-ID: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

The series updates arm64 ZTE zx296718 device trees with new devices and
a new zx296718-pcbox board support.

Shawn Guo (10):
  arm64: dts: zx296718: add VGA device support
  arm64: dts: zx296718: add I2S and I2C audio codec
  arm64: dts: zx296718: add pinctrl and gpio devices
  arm64: dts: zx296718: set a better parent clock for I2S0
  arm64: dts: zx296718: add voltage data into OPP table
  arm64: dts: zx296718: add PWM device support
  arm64: dts: zx296718: add irdec device for remote control
  arm64: dts: zx296718-evb: use audio-graph-card for HDMI audio
  arm64: dts: zx296718-evb: add I2S sound card support
  arm64: dts: zte: add initial zx296718-pcbox board support

 arch/arm64/boot/dts/zte/Makefile           |   1 +
 arch/arm64/boot/dts/zte/zx296718-evb.dts   |  68 ++++++++++--
 arch/arm64/boot/dts/zte/zx296718-pcbox.dts | 143 ++++++++++++++++++++++++
 arch/arm64/boot/dts/zte/zx296718.dtsi      | 169 +++++++++++++++++++++++++++++
 4 files changed, 373 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/zte/zx296718-pcbox.dts

-- 
1.9.1
