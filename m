From: carlo@caione.org (Carlo Caione)
Date: Mon, 2 Mar 2015 12:03:45 +0100
Subject: [GIT PULL] ARM: meson: DTS related changes
Message-ID: <CAOQ7t2a9ECE8=sbvuLesUSH-EuqipjCy0qyyboase9wrRA09tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,
here is the belated pull request for DTS related changes.
Sorry for submitting so late.

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://github.com/carlocaione/linux-meson tags/for-v4.0-rc/meson-dts

for you to fetch changes up to b3e67c9112f6268045f78a61274fda2c7250c5c9:

  ARM: dts: meson: add DTS file for MINIX NEO-X8 (2015-03-02 11:01:03 +0100)

----------------------------------------------------------------
- New DTS for MINIX NEO-X8
- Add DTS support for SPIFC, Ethernet controller and pinctrl

----------------------------------------------------------------
Beniamino Galvani (4):
      ARM: dts: meson: add node for SPIFC
      ARM: dts: meson: enable Ethernet controller
      ARM: dts: meson8: add pinctrl node
      ARM: dts: meson: add DTS file for MINIX NEO-X8

 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/meson.dtsi              |  20 +++++
 arch/arm/boot/dts/meson6-atv1200.dts      |   4 +
 arch/arm/boot/dts/meson8-minix-neo-x8.dts | 128 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8.dtsi             |  68 ++++++++++++++++
 5 files changed, 222 insertions(+)
 create mode 100644 arch/arm/boot/dts/meson8-minix-neo-x8.dts
