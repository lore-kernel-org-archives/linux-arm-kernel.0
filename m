From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 13 May 2015 17:02:48 +0200
Subject: [GIT PULL] ARM: rockchip: dts changes for 4.2
Message-ID: <1811517.bEK1crHEhh@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

except the system-power-controller patch, these are again the dts changes
that didn't make it into 4.1 anymore, now for 4.2 . 


Thanks
Heiko


The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.2-rockchip-dts1

for you to fetch changes up to 9ab79be0da98e371f1d2f9c01ac25745639718d1:

  ARM: dts: rockchip: add system-power-controller to act8846 on radxarock (2015-05-12 22:27:05 +0200)

----------------------------------------------------------------
Some misc improvements defining additional supply regulators, enabling
the Cortex-A12 HW PMU on the rk3288 and the tsadc on some more rk3288
boards, as well as some usb properties and marking the radxarock pmic
as system-power-controller.

----------------------------------------------------------------
Doug Anderson (1):
      ARM: dts: rockchip: Specify VMMC and VQMMC on rk3288-evb

Heiko Stuebner (2):
      ARM: dts: rockchip: add act8846 supplies on rk3288-firefly
      ARM: dts: rockchip: enable tsadc on rk3288 boards

Michael Niew?hner (1):
      ARM: dts: rockchip: add system-power-controller to act8846 on radxarock

Sonny Rao (1):
      ARM: dts: rockchip: Enable Cortex-A12 HW PMU events on rk3288

Yunzhi Li (1):
      ARM: dts: rockchip: add properties for dwc2 usb otg controller

 arch/arm/boot/dts/rk3188-radxarock.dts |  1 +
 arch/arm/boot/dts/rk3288-evb.dtsi      | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly.dtsi  | 14 ++++++++++++++
 arch/arm/boot/dts/rk3288-popmetal.dts  |  6 ++++++
 arch/arm/boot/dts/rk3288.dtsi          | 14 ++++++++++++++
 5 files changed, 58 insertions(+)
