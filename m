From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 05 Dec 2015 01:58:29 +0100
Subject: [GIT PULL 3/3] rockchip dts64 changes for 4.5
In-Reply-To: <1936935.FVZdWRYuBf@diego>
References: <1936935.FVZdWRYuBf@diego>
Message-ID: <1655223.OUhjUXllVj@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below rockchip arm64 changes for 4.5 .
I think the tag should explain the changes sufficiently.


Thanks
Heiko


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.5-rockchip-dts64-1

for you to fetch changes up to 5378e28c9776fbab6065cfb54417acff3ea5f1fd:

  arm64: dts: rockchip: add rk3368 evaluation board (2015-12-02 00:35:22 +0100)

----------------------------------------------------------------
First round of 64bit devicetree changes for Rockchip socs.
This includes support for the evaluation board of the rk3368
as well as the dts-part for the newly added thermal management
support, rk3368 pwm nodes and an alias.

----------------------------------------------------------------
Caesar Wang (5):
      arm64: dts: rockchip: Add the thermal data found on RK3368
      arm64: dts: rockchip: Add main thermal info to rk3368.dtsi
      arm64: dts: rockchip: Enable the Thermal on R88 board
      arm64: dts: rockchip: add the pwm node info for RK3368 SoCs
      arm64: dts: rockchip: add rk3368 evaluation board

Heiko Stuebner (1):
      arm64: dts: rockchip: Setup rk3368 ethernet0 alias for u-boot

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../arm64/boot/dts/rockchip/rk3368-evb-act8846.dts | 176 +++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi       | 281 +++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |   6 +
 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi   | 112 ++++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  97 +++++++
 7 files changed, 677 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-thermal.dtsi
