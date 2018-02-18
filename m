From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 18 Feb 2018 16:40:49 +0100
Subject: [GIT PULL 1/2] Rockchip dts32 fixes for 4.16
Message-ID: <2137280.MWbT8y5lbZ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below and in the next mail accumulated fixes for Rockchip
platforms on 4.16.

Please pull. Thanks
Heiko


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.16-rockchip-dts32fixes-1

for you to fetch changes up to e78c637127ee7683d606737f2e62b5da6fd7b1c3:

  ARM: dts: rockchip: Fix DWMMC clocks (2018-02-16 10:45:16 +0100)

----------------------------------------------------------------
Fix wrong dwmmc tuning clocks that may make probing HS cards fail to
probe and removal of special opps from the phycore boards that may
run the cpu outside the soc-vendor specs.

----------------------------------------------------------------
Daniel Schultz (1):
      ARM: dts: rockchip: Remove 1.8 GHz operation point from phycore som

Robin Murphy (1):
      ARM: dts: rockchip: Fix DWMMC clocks

 arch/arm/boot/dts/rk3036.dtsi             |  4 ++--
 arch/arm/boot/dts/rk322x.dtsi             |  6 +++---
 arch/arm/boot/dts/rk3288-phycore-som.dtsi | 20 --------------------
 3 files changed, 5 insertions(+), 25 deletions(-)
