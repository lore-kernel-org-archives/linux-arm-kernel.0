From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 28 Mar 2017 17:53:13 +0200
Subject: [GIT PULL 2/3] Rockchip dts64 updates for 4.12 part1
In-Reply-To: <5178456.jWASpzTAdU@phil>
References: <5178456.jWASpzTAdU@phil>
Message-ID: <17137029.z2AnQCnjUI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.12-rockchip-dts64-1

for you to fetch changes up to 41b464ef10219e45513d1bcaddacd47ce0bd6136:

  arm64: dts: rockchip: fix PCIe domain number for rk3399 (2017-03-22 17:50:09 +0100)

----------------------------------------------------------------
Contains various changes for the rk3368 (dma, i2s, disable mailbox per
default, mmc-resets) and also removes the wrongly added idle states, that
do not match the hardware's capabilities, as well as some general rk3399
pcie fixes as well as also the mmc resets.

----------------------------------------------------------------
Brian Norris (1):
      arm64: dts: rockchip: sort rk3399-pcie by unit address

Heiko Stuebner (3):
      arm64: dts: rockchip: remove wrongly added idle states on rk3368
      arm64: dts: rockchip: add rk3368 dw-mmc resets
      arm64: dts: rockchip: add rk3399 dw-mmc resets

Huibin Hong (1):
      arm64: dts: rockchip: add dmac nodes for rk3368 SoCs

Jianqun Xu (2):
      arm64: dts: rockchip: add i2s nodes support for RK3368 SoCs
      arm64: dts: rockchip: disable mailbox of RK3368 SoCs per default

Shawn Lin (1):
      arm64: dts: rockchip: fix PCIe domain number for rk3399

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 94 +++++++++++++++++++++++++-------
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 93 ++++++++++++++++---------------
 2 files changed, 123 insertions(+), 64 deletions(-)
