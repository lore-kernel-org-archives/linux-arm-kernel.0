From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Thu, 17 Oct 2013 21:38:01 +0200
Subject: [GIT PULL] Rockchip boards for 3.13
Message-ID: <201310172138.01672.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:

  Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.13-rockchip-boards

for you to fetch changes up to 0311caed3aa7395fe216dce16222d70a1793554f:

  MAINTAINERS: Add maintainers entry for Rockchip SoCs (2013-10-14 23:19:58 +0200)

----------------------------------------------------------------
Support for the RK3188 SoC, basic RK3188 based Radxa Rock board
and RK3066a based BQ Curie2 tablet.

----------------------------------------------------------------
Heiko Stuebner (5):
      ARM: rockchip: move shared dt properties to common source file
      ARM: rockchip: enable arm-global-timer
      ARM: rockchip: add dts for bqcurie2 tablet
      ARM: rockchip: add support for rk3188 and Radxa Rock board
      MAINTAINERS: Add maintainers entry for Rockchip SoCs

 MAINTAINERS                            |    7 +
 arch/arm/boot/dts/rk3066a-bqcurie2.dts |  109 ++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi         |   98 +----------
 arch/arm/boot/dts/rk3188-clocks.dtsi   |  289 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3188-radxarock.dts |   80 +++++++++
 arch/arm/boot/dts/rk3188.dtsi          |  253 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi          |  124 ++++++++++++++
 arch/arm/mach-rockchip/Kconfig         |    2 +
 8 files changed, 865 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3066a-bqcurie2.dts
 create mode 100644 arch/arm/boot/dts/rk3188-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/rk3188-radxarock.dts
 create mode 100644 arch/arm/boot/dts/rk3188.dtsi
 create mode 100644 arch/arm/boot/dts/rk3xxx.dtsi
