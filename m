From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 31 May 2014 04:58:57 +0900
Subject: [GIT PULL 1/5] Samsung CLK update for 3.16
Message-ID: <5388E301.7080407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bfed1074f213051e94648bfad0d0611a16d81366:

   clk: exynos5250: Add missing sysmmu clocks for DISP and ISP blocks 
(2014-05-26 06:48:10 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-clk-3

for you to fetch changes up to e7ef0b632eb45b0c725629da3561ecde8935a398:

   clk: exynos5410: register clocks using common clock framework 
(2014-05-31 02:13:16 +0900)

----------------------------------------------------------------
Samsung 3rd clock updates for 3.16

- add clock for new exynos5410 SoC

----------------------------------------------------------------
Tarek Dakhran (1):
       clk: exynos5410: register clocks using common clock framework

  .../devicetree/bindings/clock/exynos5410-clock.txt |  45 +++++
  drivers/clk/samsung/Makefile                       |   1 +
  drivers/clk/samsung/clk-exynos5410.c               | 209 
+++++++++++++++++++++
  include/dt-bindings/clock/exynos5410.h             |  33 ++++
  4 files changed, 288 insertions(+)
  create mode 100644 
Documentation/devicetree/bindings/clock/exynos5410-clock.txt
  create mode 100644 drivers/clk/samsung/clk-exynos5410.c
  create mode 100644 include/dt-bindings/clock/exynos5410.h
