From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 18 Nov 2014 16:37:14 +0100
Subject: [GIT PULL 2/2] ARM: rockchip: second batch of dts related changes
In-Reply-To: <11809616.LUBsxGXhAZ@diego>
References: <11809616.LUBsxGXhAZ@diego>
Message-ID: <10123517.vilMAMHQe0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

this is the second batch of devicetree related changes for 3.19.
I hope the tag message explains the contents enough.


The following changes since commit 11bd57b82e6802765d1a1b33405bbaff82615d65:

  ARM: dts: rockchip: Add SPI DMA into rk3288.dtsi (2014-10-25 00:07:32 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.19-rockchip-dts2

for you to fetch changes up to efb66e93d13da5a7b11b3a8dbb24a6fb29141752:

  ARM: dts: rockchip: enable PWM on Radxa Rock (2014-11-15 21:16:30 +0100)

----------------------------------------------------------------
- the dts part of the rk3288 smp support
- rate init for rk3288 clocks
- enablement of various peripherals
- new boardfile for Haoyu Marsboard (rk3066 based)

----------------------------------------------------------------
Daniel Kurtz (1):
      ARM: dts: rk3288: add VOP iommu nodes

Julien CHAUVEAU (3):
      ARM: dts: rockchip: add serial aliases for rk3066 and rk3188
      ARM: dts: rockchip: fix invalid unit-address in rk3188.dtsi
      ARM: dts: rockchip: enable PWM on Radxa Rock

Kever Yang (3):
      ARM: dts: rockchip: add pmu references to cpus nodes
      ARM: dts: rockchip: add intmem node for rk3288 smp support
      ARM: dts: rockchip: add reset for CPU nodes

Romain Perier (2):
      ARM: dts: rockchip: Add EMAC Rockchip for RK3066 SoCs
      ARM: dts: rockchip: Add devicetree source for MarsBoard RK3066

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3066a-marsboard.dts            | 192 +++++++++++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi                     |  22 +++
 arch/arm/boot/dts/rk3188-radxarock.dts             |  12 ++
 arch/arm/boot/dts/rk3188.dtsi                      |   4 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  36 ++++
 arch/arm/boot/dts/rk3xxx.dtsi                      |   4 +
 8 files changed, 273 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3066a-marsboard.dts
