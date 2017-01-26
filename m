From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Jan 2017 09:52:25 +0100
Subject: [PATCH 0/5] arm64: dts: r8a779[56]: salvator-x: Add I2C for DVFS
 device support
Message-ID: <1485420750-12701-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series enables I2C for DVFS  on the salvator-x board for the
r8a7795 and r8a7796 SoCs.

Base:
* This series is based on renesas-next-20170126-v4.10-rc2

Dependencies:
* This series has a run-time dependency on
  "[PATCH 0/2] clk: renesas: r8a7795/r8a7796: Add IIC-DVFS clock"
* This series has a check patch dependency on
  "[PATCH i2c/for-next] i2c: sh_mobile: document support for r8a7796 (R-Car M3-W)"
* This series should be safe to apply independently of the above dependencies


Dien Pham (2):
  arm64: dts: r8a7796: Add I2C for DVFS device node
  arm64: dts: r8a7796: salvator-x: Add I2C for DVFS device support

Keita Kobayashi (2):
  arm64: dts: r8a7795: Add I2C for DVFS core to dtsi
  arm64: dts: r8a7795-salvator-x: Enable I2C for DVFS device

Simon Horman (1):
  arm64: defconfig: Enable SH Mobile I2C controller

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  4 ++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 14 ++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  4 ++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 14 ++++++++++++++
 arch/arm64/configs/defconfig                       |  1 +
 5 files changed, 37 insertions(+)

-- 
2.7.0.rc3.207.g0ac5344
