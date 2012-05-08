From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 May 2012 12:31:32 -0600
Subject: [GIT PULL] ARM: tegra: dt branch
Message-ID: <4FA96684.1040608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch is based on my previous gpio-pinmux pull request.

This series instantiates many new devices from DT on Tegra boards.

The following changes since commit aef7704c6cc36db9618603b22194def441d30432:
  Stephen Warren (1):
        pinctrl: tegra: error reporting cleanup

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
for-3.5/dt

Laxman Dewangan (1):
      ARM: dt: tegra: enable als and proximity sensor

Olof Johansson (1):
      ARM: dt: tegra seaboard: add i2c devices

Stephen Warren (5):
      ARM: dt: tegra seaboard: fix I2C2 SCL rate
      ARM: dt: tegra seaboard: configure I2C2 pinmux
      ARM: dt: tegra trimslice: add RTC I2C device
      ARM: dt: tegra trimslice: enable SDHCI1 controller
      ARM: dt: tegra trimslice: add support for audio

 arch/arm/boot/dts/tegra-cardhu.dts    |    8 ++++++
 arch/arm/boot/dts/tegra-seaboard.dts  |   41
+++++++++++++++++++++++++++++---
 arch/arm/boot/dts/tegra-trimslice.dts |   24 +++++++++++--------
 arch/arm/boot/dts/tegra-ventana.dts   |    8 ++++++
 4 files changed, 67 insertions(+), 14 deletions(-)
