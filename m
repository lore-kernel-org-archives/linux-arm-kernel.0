From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 21 May 2015 10:04:50 +0200
Subject: [GIT PULL] ARM: rockchip: dts relicensing for 4.2
Message-ID: <1812361.uhqE6qDILc@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

I've managed to finally aquire all the necessary acks for relicensing
to GPL2/X11, so please pull


Thanks
Heiko

The following changes since commit 9ab79be0da98e371f1d2f9c01ac25745639718d1:

  ARM: dts: rockchip: add system-power-controller to act8846 on radxarock (2015-05-12 22:27:05 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.2-rockchip-dts2

for you to fetch changes up to cdcc8b6b241912fe0fd60e447453d87c644b1619:

  ARM: dts: rockchip: relicense rk3288-evb* under GPLv2/X11 (2015-05-15 12:25:54 +0200)

----------------------------------------------------------------
Relicense all Rockchip-related devicetree files to the GPL2/X11 combo.
I've now finally aquired necessary Acks from all contributors.

----------------------------------------------------------------
Heiko Stuebner (8):
      ARM: dts: rockchip: relicense rk3xxx.dtsi under GPLv2/X11
      ARM: dts: rockchip: relicense rk3066a.dtsi under GPLv2/X11
      ARM: dts: rockchip: relicense rk3188.dtsi under GPLv2/X11
      ARM: dts: rockchip: relicense rk3288-thermal.dtsi under GPLv2/X11
      ARM: dts: rockchip: relicense rk3066a-bqcurie2.dts under GPLv2/X11
      ARM: dts: rockchip: relicense rk3188-radxarock.dts under GPLv2/X11
      ARM: dts: rockchip: relicense rk3288.dtsi under GPLv2/X11
      ARM: dts: rockchip: relicense rk3288-evb* under GPLv2/X11

 arch/arm/boot/dts/rk3066a-bqcurie2.dts   | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3066a.dtsi           | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3188-radxarock.dts   | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3188.dtsi            | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3288-evb-act8846.dts | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3288-evb-rk808.dts   | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3288-evb.dtsi        | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3288-thermal.dtsi    | 40 ++++++++++++++++++++++++++---
 arch/arm/boot/dts/rk3288.dtsi            | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3xxx.dtsi            | 44 ++++++++++++++++++++++++++------
 10 files changed, 361 insertions(+), 75 deletions(-)
