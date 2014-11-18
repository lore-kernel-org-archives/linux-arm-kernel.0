From: carlo@caione.org (Carlo Caione)
Date: Tue, 18 Nov 2014 21:55:20 +0100
Subject: [GIT PULL] ARM: meson: DTS related changes
Message-ID: <20141118205520.GA19814@nuc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

here is the pull request for the DT related changes for the 3.19.
It's mainly the work done by Beniamino for the preliminary support of
the Amlogic Meson8 SoC, the support for L2 cache and the I2C
controller.
Please note that the support for the Tronsmart S89 Elite TV box has not
been included since the Meson8 development will be done now on a
different dev board kindly provided by Amlogic.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  https://github.com/carlocaione/linux-meson tags/v3.19-meson-dts

for you to fetch changes up to 8fba96fac1c48b242ff2b202332572b6eeef95cc:

  ARM: dts: meson: add I2C controller nodes (2014-11-18 17:22:18 +0100)

----------------------------------------------------------------
- Amlogic Meson8 support
- Enabling L2 cache for MesonX SoCs
- Add I2C controller nodes
- Bug fixing

----------------------------------------------------------------
Beniamino Galvani (3):
      ARM: dts: add dtsi for Amlogic Meson8 SoCs
      ARM: meson: DTS: enable L2 cache
      ARM: dts: meson: add I2C controller nodes

Carlo Caione (1):
      DTS: meson: Add forgotten compatible in board DTS

 arch/arm/boot/dts/meson.dtsi         | 37 +++++++++++++++
 arch/arm/boot/dts/meson6-atv1200.dts |  2 +-
 arch/arm/boot/dts/meson6.dtsi        |  2 +
 arch/arm/boot/dts/meson8.dtsi        | 92 ++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/meson8.dtsi
