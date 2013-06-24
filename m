From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 25 Jun 2013 02:09:15 +0900
Subject: [GIT PULL 2/2] Samsung Exynos5420 clock for hdmi for v3.11
Message-ID: <51C87D3B.90701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit eff4e7c7f32a4e4be60b19b209ffab5cb430b385:

   ARM: EXYNOS: extend soft-reset support for EXYNOS5420 (2013-06-19 
04:09:37 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/soc-exynos5420-3

for you to fetch changes up to 2c862cf943771b4859ecc54bc13d72b309472427:

   clk: exynos5420: assign sclk_pixel id to pixel clock divider 
(2013-06-25 01:43:42 +0900)

----------------------------------------------------------------
based on tags/soc-exynos5420-1

Add clock support hdmi subsystem on exynos5420
- add new clocks, mout_hdmi and smmu_tv, associating ID to clk_hdmiphy
- include some essential corrections

----------------------------------------------------------------
Rahul Sharma (5):
       clk: exynos5420: add sclk_hdmiphy to the list of special clocks
       clk: exynos5420: add gate clock for tv sysmmu
       clk: exynos5420: fix the order of parents of hdmi mux
       clk: exynos5420: add hdmi mux to change parents in hdmi driver
       clk: exynos5420: assign sclk_pixel id to pixel clock divider

  .../devicetree/bindings/clock/exynos5420-clock.txt     |  7 +++++++
  drivers/clk/samsung/clk-exynos5420.c                   | 18 
+++++++++++-------
  2 files changed, 18 insertions(+), 7 deletions(-)
