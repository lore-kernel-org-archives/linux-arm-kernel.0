From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 22 Nov 2018 13:32:42 +0100
Subject: [GIT PULL 2/2] Rockchip arm64 devicetree fixes for 4.20
In-Reply-To: <110221357.jpgQ0Qy0za@phil>
References: <110221357.jpgQ0Qy0za@phil>
Message-ID: <3222605.xbTO2UFBUd@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.20-rockchip-dts64fixes-1

for you to fetch changes up to c1d91f86a1b4c9c05854d59c6a0abd5d0f75b849:

  arm64: dts: rockchip: Fix PCIe reset polarity for rk3399-puma-haikou. (2018-11-13 15:02:07 +0100)

----------------------------------------------------------------
Removal of vdd_log regulator on rk960 to fix a stability issue
and fixup of the pcie reset polarity on puma-haikou.

----------------------------------------------------------------
Christoph Muellner (1):
      arm64: dts: rockchip: Fix PCIe reset polarity for rk3399-puma-haikou.

Daniel Lezcano (1):
      arm64: dts: rockchip: remove vdd_log from rock960 to fix a stability issues

 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi    | 12 ------------
 2 files changed, 1 insertion(+), 13 deletions(-)
