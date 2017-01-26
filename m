From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Jan 2017 11:11:05 +0100
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.11
Message-ID: <cover.1485425227.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for v4.11.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v4.11,
which you have already pulled.


The following changes since commit 654450baf2afba86cf328e1849ccac61ec4630af:

  ARM: dts: r8a7790: Use R-Car Gen 2 fallback binding for msiof nodes (2017-01-03 10:47:05 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.11

for you to fetch changes up to 5786ac14239a0809ca13e6a6f77147e6bb04aa29:

  ARM: dts: r7s72100: add power-domains to mmcif (2017-01-25 11:32:02 +0100)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.11

Enhancements:
* Add power-domains to mmcif on r7s72100 SoC
* Add OSTM to rskrza1/r7s72100
* Link ARM GIC to clock and clock domain on r8a774[35] SoCs

Clean-up:
* Correct SATA device status on r8a7779/marzen

----------------------------------------------------------------
Chris Brandt (4):
      ARM: dts: r7s72100: add ostm clock to device tree
      ARM: dts: r7s72100: add ostm to device tree
      ARM: dts: rskrza1: add ostm DT support
      ARM: dts: r7s72100: add power-domains to mmcif

Geert Uytterhoeven (3):
      ARM: dts: r8a7779, marzen: Fix sata device status
      ARM: dts: r8a7743: Link ARM GIC to clock and clock domain
      ARM: dts: r8a7745: Link ARM GIC to clock and clock domain

 arch/arm/boot/dts/r7s72100-rskrza1.dts     |  8 ++++++++
 arch/arm/boot/dts/r7s72100.dtsi            | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7743.dtsi             |  3 +++
 arch/arm/boot/dts/r8a7745.dtsi             |  3 +++
 arch/arm/boot/dts/r8a7779-marzen.dts       |  4 ++++
 arch/arm/boot/dts/r8a7779.dtsi             |  1 +
 include/dt-bindings/clock/r7s72100-clock.h |  4 ++++
 7 files changed, 51 insertions(+)
