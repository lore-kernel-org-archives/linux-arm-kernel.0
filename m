From: tushar.b@samsung.com (Tushar Behera)
Date: Fri, 11 Jul 2014 17:30:32 +0530
Subject: [PATCH V2 0/3] clk: exynos-audss: Adapt to exising clock framework
Message-ID: <1405080036-6651-1-git-send-email-tushar.b@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generic cleanup and usage of samsung clock register/unregister APIs.

The patches are tested on Exynos5800 based Peach-Pi board. More tests are
welcome.

Tushar Behera (3):
  clk: exynos-audss: Simplify code to get clock names
  clk: samsung: Add API to unregister clocks
  clk: exynos-audss: Use samsung clock APIs to register/unregister
    clocks

 drivers/clk/samsung/clk-exynos-audss.c |  179 +++++++++++++-------------------
 drivers/clk/samsung/clk.c              |   19 ++++
 drivers/clk/samsung/clk.h              |    2 +
 3 files changed, 95 insertions(+), 105 deletions(-)

-- 
1.7.9.5
