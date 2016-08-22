From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 22 Aug 2016 11:49:43 +0900
Subject: [PATCH 0/2] clk: samsung: Move struct samsung_cmu_info to init section
Message-ID: <1471834185-20249-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset moves the struct samsung_cmu_info to init section for
exynos5260/5410 because they are used only in initconst section.

Chanwoo Choi (2):
  clk: samsung: exynos5260: Move struct samsung_cmu_info to init section
  clk: samsung: exynos5410: Use samsung_cmu_register_one() to simplify code

 drivers/clk/samsung/clk-exynos5260.c | 350 +++++++++++++++++------------------
 drivers/clk/samsung/clk-exynos5410.c |  33 ++--
 2 files changed, 188 insertions(+), 195 deletions(-)

-- 
1.9.1
