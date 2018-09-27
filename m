From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 27 Sep 2018 12:01:53 +0200
Subject: [GIT PULL] ARM: dts: Amlogic updates for v4.20
Message-ID: <7ha7o345ta.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt

for you to fetch changes up to 54ef8539f5a3c3da0a415c4afa41556547c973fd:

  ARM: dts: meson8b: odroidc1: add stdout-path property (2018-09-26 01:49:49 -0700)

----------------------------------------------------------------
ARM: dts: Amlogic updates for v4.20
- fix clock controller register sizes
- new board: Endless Mini (EC-100) by Endless Mobile
- add voltage regulators

----------------------------------------------------------------
Martin Blumenstingl (11):
      ARM: dts: meson8: fix the clock controller register size
      ARM: dts: meson8b: fix the clock controller register size
      dt-bindings: add vendor prefix for "Endless Mobile, Inc."
      dt-bindings: arm: amlogic: Add the Endless Mobile Endless Mini (EC-100)
      ARM: dts: meson8b: add the I2C_A, PWM_C and UART_B pins
      ARM: dts: meson8b: add the RMII pins
      ARM: dts: meson8b: Add support for the Endless Mini (EC-100)
      ARM: dts: meson8b: odroidc1: add the CPU voltage regulator
      ARM: dts: meson8b: odroidc1: add the fixed voltage regulators
      ARM: dts: meson8b: odroidc1: enable the SAR ADC
      ARM: dts: meson8b: odroidc1: add stdout-path property

 Documentation/devicetree/bindings/arm/amlogic.txt     |   1 +
 Documentation/devicetree/bindings/vendor-prefixes.txt |   1 +
 arch/arm/boot/dts/Makefile                            |   1 +
 arch/arm/boot/dts/meson8.dtsi                         |   2 +-
 arch/arm/boot/dts/meson8b-ec100.dts                   | 248 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8b-odroidc1.dts                | 109 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi                        |  47 ++++++++++++-
 7 files changed, 407 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/meson8b-ec100.dts
