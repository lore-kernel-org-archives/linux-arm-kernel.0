From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 17 Oct 2017 19:40:45 +0200
Subject: [GIT PULL 2/2] Rockchip dts64 updates for 4.15 part1
In-Reply-To: <5843673.lOC77YXMZV@phil>
References: <5843673.lOC77YXMZV@phil>
Message-ID: <5888991.PG7Gbs0CIl@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.15-rockchip-dts64-1

for you to fetch changes up to d85438991874205467f9739d5f3ee771245b4754:

  arm64: dts: rockchip: enable cec pin for rk3399 firefly (2017-10-15 14:11:32 +0200)

----------------------------------------------------------------
The biggest step forward is probably the enablement of display support
on the rk3399-firefly, which got its default serial set as well and
got cec support as well.
Gru boards got their touchpad support refined to actually mark the button
correctly and also git their rt5514 dsp added.
And finally the rk3328 eval board got its cpu regulator and mmc nodes.

----------------------------------------------------------------
Emil Renner Berthing (1):
      arm64: dts: rockchip: enable touchpad button for rk3399-gru-kevin

Heiko Stuebner (1):
      arm64: dts: rockchip: enable display subsystem on rk3399-firefly

Heinrich Schuchardt (1):
      arm64: dts: rockchip: default serial for Firefly-RK3399

Jeffy Chen (1):
      arm64: dts: rockchip: Add rt5514 dsp for rk3399 gru

Liang Chen (2):
      arm64: dts: rockchip: add mmc nodes for rk3328 evaluation board
      arm64: dts: rockchip: add cpu regulator for rk3328 evaluation board

Pierre-Hugues Husson (2):
      arm64: dts: rockchip: add the cec clk for dw-mipi-hdmi on rk3399
      arm64: dts: rockchip: enable cec pin for rk3399 firefly

 arch/arm64/boot/dts/rockchip/rk3328-evb.dts       | 72 ++++++++++++++++++++++-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts   | 27 +++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts |  4 ++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi      |  3 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi          |  8 ++-
 5 files changed, 110 insertions(+), 4 deletions(-)
