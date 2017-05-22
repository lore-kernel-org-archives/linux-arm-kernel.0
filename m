From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 14:30:18 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.13
Message-ID: <cover.1495455272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.13.

This pull request is based on "Renesas ARM Based SoC DT Bindings Updates
for v4.13", dt-bindings-for-v4.13, which I have also sent a pull-request
for.


The following changes since commit 40c9bbea140e64a4257b794969e759c2c481c399:

  ARM: dts: r7s72100: add USB bit definitions (2017-05-15 09:02:37 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.13

for you to fetch changes up to 2ae0fcc57e00c11fae80678e2a9fabbeec82a185:

  ARM: dts: renesas: Switch to panel-lvds bindings for Mitsubishi panels (2017-05-15 11:14:39 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.13

* Switch to panel-lvds bindings for Mitsubishi panels
* Clean up PFC node names
* Enable UHS-I SDR-50 and SDR-104 on r8a7793/Gose
* Add GyroADC clock and device for r8a7791 SoC
* Add USB clocks to device tree for r7s72100 SoC

----------------------------------------------------------------
Chris Brandt (1):
      ARM: dts: r7s72100: add usb clocks to device tree

Laurent Pinchart (1):
      ARM: dts: renesas: Switch to panel-lvds bindings for Mitsubishi panels

Marek Vasut (1):
      ARM: dts: r8a7791: Add GyroADC clock and device node

Simon Horman (11):
      ARM: dts: emev2: update PFC node name to pin-controller
      ARM: dts: r8a73a4: update PFC node name to pin-controller
      ARM: dts: r8a7740: update PFC node name to pin-controller
      ARM: dts: r8a7778: update PFC node name to pin-controller
      ARM: dts: r8a7779: update PFC node name to pin-controller
      ARM: dts: r8a7790: update PFC node name to pin-controller
      ARM: dts: r8a7791: update PFC node name to pin-controller
      ARM: dts: r8a7793: update PFC node name to pin-controller
      ARM: dts: sh73a0: update PFC node name to pin-controller
      ARM: dts: r8a7793: set maximum frequency for SDHI clocks
      ARM: dts: gose: Enable UHS-I SDR-50 and SDR-104

 arch/arm/boot/dts/emev2.dtsi                   |  2 +-
 arch/arm/boot/dts/r7s72100.dtsi                |  6 ++---
 arch/arm/boot/dts/r8a73a4.dtsi                 |  2 +-
 arch/arm/boot/dts/r8a7740.dtsi                 |  2 +-
 arch/arm/boot/dts/r8a7778.dtsi                 |  2 +-
 arch/arm/boot/dts/r8a7779.dtsi                 |  2 +-
 arch/arm/boot/dts/r8a7790.dtsi                 |  2 +-
 arch/arm/boot/dts/r8a7791.dtsi                 | 16 ++++++++++--
 arch/arm/boot/dts/r8a7793-gose.dts             | 34 +++++++++++++++++++++++---
 arch/arm/boot/dts/r8a7793.dtsi                 |  5 +++-
 arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi |  3 ++-
 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi |  3 ++-
 arch/arm/boot/dts/sh73a0.dtsi                  |  2 +-
 13 files changed, 63 insertions(+), 18 deletions(-)
