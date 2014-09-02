From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 03 Sep 2014 00:06:53 +0200
Subject: [GIT PULL] rockchip dma support
Message-ID: <1573460.mA2d3uShjW@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

this adds support for the pl330 dma controllers found on all Rockchip SoCs
currently supported (rk3066, rk3188 and rk3288), so please pull


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.18-rockchip-dma

for you to fetch changes up to ac42f481b75b98076b47fac60796657508f80abe:

  ARM: dts: rockchip: add rk3066 and rk3188 dma controllers (2014-09-02 22:28:32 +0200)

----------------------------------------------------------------
Enable the AMBA bus and add necessary dma-controller dts nodes

----------------------------------------------------------------
Heiko St?bner (3):
      ARM: rockchip: enable the AMBA bus
      ARM: dts: rockchip: add rk3288 dma controllers
      ARM: dts: rockchip: add rk3066 and rk3188 dma controllers

 arch/arm/boot/dts/rk3288.dtsi  | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi  | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig |  1 +
 3 files changed, 77 insertions(+)
