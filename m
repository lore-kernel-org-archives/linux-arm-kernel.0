From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 22 Sep 2014 16:26:26 +0200
Subject: [GIT PULL RESEND] rk3288 i2s controller
Message-ID: <4038555.EtoLsBADBk@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

this one is separate and based on the dma pull, as it uses the new dma nodes.

While everything will of course work in next/dt of arm-soc where both my
past pulls landed, it would produce build errors in rockchip/dts1 [if the 
kbuild
robot tried to "make dtbs" there] as the dma patches not in there.

[RESEND because I forgot the mailinglists :-( ]


The following changes since commit ac42f481b75b98076b47fac60796657508f80abe:

  ARM: dts: rockchip: add rk3066 and rk3188 dma controllers (2014-09-02 
22:28:32 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git 
tags/v3.18-rockchip-i2s-dts

for you to fetch changes up to a73a62aa4c99e9df1574ac6e54fbddffa88a460f:

  ARM: dts: add rk3288 i2s controller (2014-09-22 11:53:12 +0200)

----------------------------------------------------------------
I2S controller support or rk3288

----------------------------------------------------------------
Jianqun (1):
      ARM: dts: add rk3288 i2s controller

 arch/arm/boot/dts/rk3288.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
