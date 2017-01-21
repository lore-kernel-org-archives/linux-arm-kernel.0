From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 21 Jan 2017 01:12:01 +0100
Subject: [GIT PULL 3/3] Rockchip dts64 updates for 4.11 part1
In-Reply-To: <6458001.3c0YmcoF8y@phil>
References: <6458001.3c0YmcoF8y@phil>
Message-ID: <7817230.eJtdPce88n@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.11-rockchip-dts64-1

for you to fetch changes up to 8cbb59af7ecf183b1761a178835e1c771167fa28:

  arm64: dts: rockchip: add rockchip,grf property for RK3399 PMUCRU/CRU (2017-01-13 20:03:15 +0100)

----------------------------------------------------------------
64bit dts changes with some adjustments to the pcie controller,
usb clocks, grf phandles for the rk3399 CRUs, epd pinctrl settings,
a phandle to the rk3399 tsadc and converting boards to use the
recently introduced pin constants.

----------------------------------------------------------------
Andy Yan (1):
      arm64: dts: rockchip: use pin constants to describe gpios

Brian Norris (2):
      arm64: dts: rockchip: add rk3399 thermal_zones phandle
      arm64: dts: rockchip: add rk3399 eDP HPD pinctrl

Shawn Lin (2):
      arm64: dts: rockchip: add max-link-speed for rk3399
      arm64: dts: rockchip: add aspm-no-l0s for rk3399

William wu (1):
      arm64: dts: rockchip: add u2phy clock for ehci and ohci of rk3399

Xing Zheng (1):
      arm64: dts: rockchip: add rockchip,grf property for RK3399 PMUCRU/CRU

 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi       | 10 +++---
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts    | 10 +++---
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    | 14 ++++----
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts    | 10 +++---
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        | 16 ++++-----
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |  8 ++---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 41 +++++++++++++++++-----
 7 files changed, 66 insertions(+), 43 deletions(-)
