From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 May 2014 13:03:27 +0900
Subject: [GIT PULL 3rd 3/3] Samsung clk-2 updates for 3.16
Message-ID: <035801cf7897$72d573e0$58805ba0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6520e968eef4f88c076a84a80e026049d157132e:

  clk: exynos5420: Add 5800 specific clocks (2014-05-19 22:15:08 +0900)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-clk-2

for you to fetch changes up to bfed1074f213051e94648bfad0d0611a16d81366:

  clk: exynos5250: Add missing sysmmu clocks for DISP and ISP blocks
(2014-05-26 06:48:10 +0900)

----------------------------------------------------------------
Samsung 2nd clock updates for 3.16	

- Add missing sysmmu clocks for DISP and ISP blocks for exynos5250

----------------------------------------------------------------
Cho KyongHo (1):
      clk: exynos5250: Add missing sysmmu clocks for DISP and ISP blocks

 drivers/clk/samsung/clk-exynos5250.c   |   35
++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/exynos5250.h |   16 +++++++++++++++
 2 files changed, 51 insertions(+)
