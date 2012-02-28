From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Feb 2012 10:33:21 +0800
Subject: [GIT PULL] imx DT changes for v3.4
Message-ID: <20120228023319.GF13886@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following imx DT changes for v3.4.

Regards,
Shawn

The following changes since commit 6b21d18ed50c7d145220b0724ea7f2613abf0f95:

  Linux 3.3-rc5 (2012-02-25 12:18:16 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/dt

Richard Zhao (2):
      ARM: dts: imx6q-sabrelite: add 2p5v and 3p3v regulators
      ARM: dts: imx6q-sabrelite: add sgtl5000 audio codec

Sascha Hauer (1):
      ARM i.MX5/6: Add dt support for generic boards

Shawn Guo (4):
      ARM: imx5: generate dtbs for imx5 boards
      ARM: dts: imx51-babbage: update mc13892 device
      ARM: dts: imx6q-arm2: add vmmc-supply for usdhc
      ARM: dts: imx6q-sabrelite: add vmmc-supply for usdhc

 arch/arm/boot/dts/imx51-babbage.dts   |   91 ++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx6q-arm2.dts      |   14 +++++
 arch/arm/boot/dts/imx6q-sabrelite.dts |   34 ++++++++++++
 arch/arm/mach-imx/Makefile.boot       |    3 +
 arch/arm/mach-imx/imx51-dt.c          |    1 +
 arch/arm/mach-imx/imx53-dt.c          |    1 +
 arch/arm/mach-imx/mach-imx6q.c        |    1 +
 7 files changed, 143 insertions(+), 2 deletions(-)
