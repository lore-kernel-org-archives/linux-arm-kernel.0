From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 28 Jul 2014 13:48:45 +0200
Subject: [GIT PULL 1/2] ARM: dts: support for Rockchip RK3288
In-Reply-To: <2320363.GkHcuEZQtr@diego>
References: <2320363.GkHcuEZQtr@diego>
Message-ID: <10597631.GFKQk34LQm@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1fe69496cf463b654d2d6e1a9a10fb8d99f10831:

  ARM: rockchip: Select ARCH_HAS_RESET_CONTROLLER (2014-07-13 12:17:11 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.17-rockchip-rk3288

for you to fetch changes up to b1db66b818a4cb1a654ae51a5ca32a09d1ccd825:

  ARM: dts: Build dtbs for Rockchip boards (2014-07-26 13:07:27 +0200)

----------------------------------------------------------------
Initial support for Rockchip RK3288 SoCs.

----------------------------------------------------------------
Doug Anderson (1):
      ARM: dts: Build dtbs for Rockchip boards

Heiko Stuebner (7):
      dt-bindings: arm: add cortex-a12 and cortex-a17 cpu compatible properties
      ARM: rockchip: clarify usability of DEBUG_RK3X_UART debug_ll options
      ARM: rockchip: add debug uart used by rk3288
      ARM: Kconfig: set default gpio number for rockchip SoCs
      ARM: rockchip: enable support for RK3288 SoCs
      ARM: dts: rockchip: add core rk3288 dtsi
      ARM: dts: add rk3288 evaluation board

 Documentation/devicetree/bindings/arm/cpus.txt |   2 +
 arch/arm/Kconfig                               |   1 +
 arch/arm/Kconfig.debug                         |  20 +-
 arch/arm/boot/dts/Makefile                     |   5 +
 arch/arm/boot/dts/rk3288-evb-act8846.dts       | 134 ++++++
 arch/arm/boot/dts/rk3288-evb-rk808.dts         |  18 +
 arch/arm/boot/dts/rk3288-evb.dtsi              |  74 ++++
 arch/arm/boot/dts/rk3288.dtsi                  | 575 +++++++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig                 |   1 +
 arch/arm/mach-rockchip/rockchip.c              |   1 +
 10 files changed, 826 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-evb-act8846.dts
 create mode 100644 arch/arm/boot/dts/rk3288-evb-rk808.dts
 create mode 100644 arch/arm/boot/dts/rk3288-evb.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288.dtsi
