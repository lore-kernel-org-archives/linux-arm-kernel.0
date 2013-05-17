From: jiada_wang@mentor.com (Jiada Wang)
Date: Fri, 17 May 2013 17:40:43 +0900
Subject: [PATCH 0/2] remove MLB PLL clock device
Message-ID: <1368780045-6481-1-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As MLB PLL is not suitable to be handled outside MLB driver.
This patch series removes MLB PLL (pll8_mlb) from clk-imx6q
and pllv3.

Jiada Wang (2):
  ARM: imx: disable pll8_mlb in mx6q_clks
  ARM: imx: remove MLB PLL from pllv3

 arch/arm/mach-imx/clk-imx6q.c |  1 -
 arch/arm/mach-imx/clk-pllv3.c | 10 ----------
 arch/arm/mach-imx/clk.h       |  1 -
 3 files changed, 12 deletions(-)

-- 
1.8.1.1
