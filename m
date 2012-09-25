From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Sep 2012 09:02:04 +0200
Subject: [PATCH v2] ARM i.MX25: Add devicetree support
Message-ID: <1348556526-9174-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Changes since v1:

- Fix typo i.MX6Q -> i.MX25
- Add EMI bus and NFC controller on it
- change i2c compatible from i.MX1 to i.MX21

Sascha

The following changes since commit 979570e02981d4a8fc20b3cc8fd651856c98ee9d:

  Linux 3.6-rc7 (2012-09-23 18:10:57 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx25-devicetree

for you to fetch changes up to 91ce175b5d9a1de747583e0a2b717129d3cc26ef:

  ARM i.MX25: Add devicetree (2012-09-25 08:54:04 +0200)

----------------------------------------------------------------
This Adds devicetree support for the Freesale i.MX25 SoC

----------------------------------------------------------------
Sascha Hauer (2):
      ARM i.MX25: Add devicetree support
      ARM i.MX25: Add devicetree

 .../devicetree/bindings/clock/imx25-clock.txt      |  121 +++++
 arch/arm/boot/dts/imx25.dtsi                       |  477 ++++++++++++++++++++
 arch/arm/mach-imx/Kconfig                          |    7 +
 arch/arm/mach-imx/Makefile                         |    1 +
 arch/arm/mach-imx/clk-imx25.c                      |   56 ++-
 arch/arm/mach-imx/imx25-dt.c                       |   48 ++
 arch/arm/plat-mxc/include/mach/common.h            |    1 +
 7 files changed, 707 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx25-clock.txt
 create mode 100644 arch/arm/boot/dts/imx25.dtsi
 create mode 100644 arch/arm/mach-imx/imx25-dt.c
