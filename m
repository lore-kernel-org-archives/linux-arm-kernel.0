From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 24 Nov 2016 16:42:35 +0100
Subject: [GIT PULL 2/3] Rockchip dts64 changes for 4.10
In-Reply-To: <1594090.z775ZFR2cz@phil>
References: <1594090.z775ZFR2cz@phil>
Message-ID: <1856918.gK9kzau163@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c49590691f3819bb6be3f77938ef39038eb76643:

  arm64: dts: rockchip: replace to "max-frequency" instead of "clock-freq-min-max" (2016-11-09 15:08:55 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.10-rockchip-dts64-2

for you to fetch changes up to c6f049db0a783a35685104e83214c9cc02fb74b6:

  dt-bindings: add rockchip RK1108 Evaluation board (2016-11-21 21:47:02 +0100)

----------------------------------------------------------------
Some more powerdomains and usb2-otg support for the rk3399 as well
as the binding doc for the 32bit rk1108 eval board to prevent it
from conflicting with the recently added 64bit px5 board.

----------------------------------------------------------------
Andy Yan (1):
      dt-bindings: add rockchip RK1108 Evaluation board

Elaine Zhang (2):
      arm64: dts: rockchip: add eMMC's power domain support for rk3399
      arm64: dts: rockchip: add pd_sd power-domain node for rk3399

Jeffy Chen (1):
      arm64: dts: rockchip: add gmac needed pclk for rk3399 pd

William Wu (1):
      arm64: dts: rockchip: add usb2-phy otg-port support for rk3399

Yakir Yang (1):
      arm64: dts: rockchip: add backlight support for rk3399 evb board

 Documentation/devicetree/bindings/arm/rockchip.txt |  4 ++
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        | 40 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 46 +++++++++++++++++++++-
 3 files changed, 89 insertions(+), 1 deletion(-)
