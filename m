From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 29 Oct 2014 17:12:02 +0100
Subject: [GIT PULL 1/2] first bunch on Rockchip dt changes
Message-ID: <8735180.PYWUSJW9sD@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

here is a first bunch of devicetree changes for 3.19.

Mainly it is the cpufreq support that came to late for 3.18 + some smaller
changes as explained in the tag.

So if this looks ok, please pull


Thanks
Heiko


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.19-rockchip-dts1

for you to fetch changes up to 11bd57b82e6802765d1a1b33405bbaff82615d65:

  ARM: dts: rockchip: Add SPI DMA into rk3288.dtsi (2014-10-25 00:07:32 +0200)

----------------------------------------------------------------
First hunk of rockchip devicetree patches, containing:
- cpu operating points and supplies
- dma support for spi controllers
- i2s on rk3066 and rk3188
- default core clock settings for rk3288

----------------------------------------------------------------
Doug Anderson (1):
      ARM: dts: rockchip: Add SPI DMA into rk3288.dtsi

Heiko Stuebner (2):
      ARM: dts: rockchip: add operating points and armclk references
      ARM: dts: rockchip: add cpu supplies to boards

Julien CHAUVEAU (2):
      ARM: dts: rockchip: enable DMA on SPI for rk3066 and rk3188
      ARM: dts: rockchip: add I2S controllers for rk3066 and rk3188

Kever Yang (1):
      ARM: dts: rockchip: enable init rate for clock

 arch/arm/boot/dts/rk3066a-bqcurie2.dts |  4 ++
 arch/arm/boot/dts/rk3066a.dtsi         | 93 +++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/rk3188-radxarock.dts |  6 ++-
 arch/arm/boot/dts/rk3188.dtsi          | 41 ++++++++++++++-
 arch/arm/boot/dts/rk3288-evb-rk808.dts |  6 ++-
 arch/arm/boot/dts/rk3288.dtsi          | 35 ++++++++++++-
 arch/arm/boot/dts/rk3xxx.dtsi          |  4 ++
 7 files changed, 184 insertions(+), 5 deletions(-)
