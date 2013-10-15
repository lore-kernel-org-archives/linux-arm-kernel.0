From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 15 Oct 2013 19:41:14 +0200
Subject: [PATCH 0/7] clk: samsung: Exynos 5250 clock clean-up
Message-ID: <1381858881-25611-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a clean-up series for the Exynos 5250 clock driver. It consists
mostly of stylistical fixes and also changes making the clock tree defined
by the driver represent more closely the real clock tree of the SoC.

On Exynos 5250 based Arndale board:
Tested-by: Tomasz Figa <t.figa@samsung.com>

Tomasz Figa (7):
  clk: samsung: exynos5250: Sort definitions by registers and bitfield
  clk: samsung: exynos5250: Make names of mux and div clocks consistent
  clk: samsung: exynos5250: Fix parents of gate clocks from GSCL domain
  clk: samsung: exynos5250: Fix parent of gate clocks from DISP1 domain
  clk: samsung: exynos5250: Add missing unpopulated mux parents
  clk: samsung: exynos5250: Correct parent list of audio muxes
  clk: samsung: exynos5250: Fix parents of gate clocks from MFC domain

 drivers/clk/samsung/clk-exynos5250.c | 404 ++++++++++++++++++++++-------------
 1 file changed, 256 insertions(+), 148 deletions(-)

-- 
1.8.3.2
