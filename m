From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 May 2014 11:39:03 +0200
Subject: [GIT PULL] ARM: rockchip: devicetree changes for  v3.16
Message-ID: <2444863.NDeixHyn6k@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a798c10faf62a505d24e5f6213fbaf904a39623f:

  Linux 3.15-rc2 (2014-04-20 11:08:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.16-rockchip-dt

for you to fetch changes up to 56f2b894dcf455ffd31bd2e8e96a074249aeb4ba:

  ARM: dts: rockchip: convert pinctrl nodes to new bindings (2014-05-10 01:41:20 +0200)

----------------------------------------------------------------
Addition of missing board compatible names and their vendor-prefixes
as well as the dts portions of the pinctrl rework.

----------------------------------------------------------------
Beniamino Galvani (2):
      of: add mundoreader and radxa vendor prefixes
      ARM: dts: rockchip: add root compatible properties

Heiko Stuebner (1):
      ARM: dts: rockchip: convert pinctrl nodes to new bindings

 Documentation/devicetree/bindings/arm/rockchip.txt    | 10 ++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt |  2 ++
 arch/arm/boot/dts/rk3066a-bqcurie2.dts                |  1 +
 arch/arm/boot/dts/rk3066a.dtsi                        |  2 +-
 arch/arm/boot/dts/rk3188-radxarock.dts                |  1 +
 arch/arm/boot/dts/rk3188.dtsi                         |  9 ++++-----
 arch/arm/boot/dts/rk3xxx.dtsi                         |  9 +++++++--
 7 files changed, 26 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip.txt
