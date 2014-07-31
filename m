From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 31 Jul 2014 07:24:15 +0200
Subject: [GIT PULL] two more dts changes for Rockchip Cortex-A9 SoCs
Message-ID: <1507670.CGuyIht1az@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

as it late in the cycle, this may not be appropriate anymore, but if it
is still applicable, please pull

The following changes since commit 08567053f5cc4255ab53b75277b6102a3202bd75:

  ARM: dts: rk3188-radxarock: add GPIO IR receiver node (2014-07-27 00:25:59 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.17-rockchip-rk3xxx-dts-2

for you to fetch changes up to eb2b9d47dd907eba5d766d942723811393454346:

  ARM: dts: rockchip: add watchdog node (2014-07-30 12:14:44 +0200)

----------------------------------------------------------------
Watchdog nodes and a duplicate pinctrl property.

----------------------------------------------------------------
Heiko Stuebner (2):
      ARM: dts: rockchip: remove pinctrl setting from radxarock uart2
      ARM: dts: rockchip: add watchdog node

 arch/arm/boot/dts/rk3066a-bqcurie2.dts | 4 ++++
 arch/arm/boot/dts/rk3066a.dtsi         | 4 ++++
 arch/arm/boot/dts/rk3188-radxarock.dts | 6 ++++--
 arch/arm/boot/dts/rk3188.dtsi          | 4 ++++
 arch/arm/boot/dts/rk3xxx.dtsi          | 8 ++++++++
 5 files changed, 24 insertions(+), 2 deletions(-)
