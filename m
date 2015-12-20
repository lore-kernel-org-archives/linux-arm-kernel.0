From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 20 Dec 2015 23:18:01 +0100
Subject: [GIT PULL] LPC18xx DTS changes for v4.5
Message-ID: <1450649881-5677-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc team,

Please consider pulling these DTS changes for the NXP LPC18xx
platform and related boards into arm-soc/dt.

Contain DTS additions for drivers that went upstream during the
previous merge cycle and some board updates.

Sorry for the late pull request. Hope it's not too late.

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://github.com/manabian/linux-lpc.git tags/lpc18xx_dts_for_4.5

for you to fetch changes up to 5743520806db4731cc30fad4cb2f01f0501a930c:

  ARM: dts: lpc4337-ciaa: add i2c0 and devices (2015-12-14 23:13:06 +0100)

----------------------------------------------------------------
Device Tree additions for LPC18xx platform

NXP LPC18xx EEPROM support plus board updates for CIAA board and
EA4357 Dev kit.

----------------------------------------------------------------
Ariel D'Alessandro (3):
      ARM: dts: lpc18xx: add EEPROM memory node
      ARM: dts: lpc4337-ciaa: enable SCT-PWM
      ARM: dts: lpc4337-ciaa: add i2c0 and devices

Joachim Eastwood (2):
      ARM: dts: lpc4357: enable EEPROM memory
      ARM: dts: lpc4357-ea4357: add mma7455 i2c accelerometer

 arch/arm/boot/dts/lpc18xx.dtsi              | 11 ++++++++++
 arch/arm/boot/dts/lpc4337-ciaa.dts          | 34 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts |  5 +++++
 arch/arm/boot/dts/lpc4357.dtsi              |  4 ++++
 4 files changed, 54 insertions(+)
