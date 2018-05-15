From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 May 2018 12:38:49 +0200
Subject: [GIT PULL 2/4] Rockchip dts32 updates for 4.18 round 1
In-Reply-To: <2000491.bLgWuj0xar@phil>
References: <2000491.bLgWuj0xar@phil>
Message-ID: <2461510.NP0ZiRnFEz@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.18-rockchip-dts32-1

for you to fetch changes up to 08624814cbec12b1ce877bf80f6990ad2b9cdcd7:

  ARM: dts: rockchip: default serial for rk3288 Tinker Board (2018-04-20 14:55:07 +0200)

----------------------------------------------------------------
Fixed pin numbers for uart4 on rk3288, iommu clocks and small changes
over multiple boards like default serial setting for rk3288-tinker,
output selection for the dp83867 on the phycore-som and the newly
added pwm-backlight delay properties for veyron boards.

----------------------------------------------------------------
Daniel Schultz (1):
      ARM: dts: rockchip: Add dp83867 CLK_OUT muxing on rk3288-phycore-som

Enric Balletbo i Serra (2):
      ARM: dts: rockchip: set PWM delay backlight settings for Veyron
      ARM: dts: rockchip: set PWM delay backlight settings for Minnie

Heinrich Schuchardt (1):
      ARM: dts: rockchip: default serial for rk3288 Tinker Board

Jacob Chen (1):
      ARM: dts: rockchip: fix uart4 pin-numbers for rk3288

Jeffy Chen (1):
      ARM: dts: rockchip: add clocks in iommu nodes

 arch/arm/boot/dts/rk3036.dtsi                   |  2 ++
 arch/arm/boot/dts/rk322x.dtsi                   |  8 ++++++++
 arch/arm/boot/dts/rk3288-phycore-som.dtsi       |  1 +
 arch/arm/boot/dts/rk3288-tinker.dts             |  4 ++++
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi |  3 ++-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts      |  2 ++
 arch/arm/boot/dts/rk3288.dtsi                   | 20 ++++++++++++++++----
 7 files changed, 35 insertions(+), 5 deletions(-)
