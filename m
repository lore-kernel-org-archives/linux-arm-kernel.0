From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 27 Aug 2016 16:33:11 +0200
Subject: [GIT PULL] LPC18xx DTS changes for v4.9
Message-ID: <20160827143311.7303-1-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc team,

Please consider pulling these DTS changes for the NXP LPC18xx
platform into arm-soc/dt for Linux 4.9.

Just a couple of small patches this time around.

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://github.com/manabian/linux-lpc.git tags/lpc18xx_dts_for_4.9

for you to fetch changes up to 3ed6d3cb14097218629ace56aa1a2d0a862b3125:

  ARM: dts: lpc18xx: configure dwmac properly (2016-08-27 16:13:19 +0200)

----------------------------------------------------------------
Device Tree additions for LPC18xx platform

Small fix for the compatible string for the NXP SE97 I2C chip on the
Hitex Eval board from Guenter and a couple of additional DT properties
for the DWMAC that is need for correct operation.

----------------------------------------------------------------
Guenter Roeck (1):
      ARM: dts: lpc4350-hitex-eval: fix binding for SE97 i2c device

Joachim Eastwood (1):
      ARM: dts: lpc18xx: configure dwmac properly

 arch/arm/boot/dts/lpc18xx.dtsi           | 4 ++++
 arch/arm/boot/dts/lpc4350-hitex-eval.dts | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)
