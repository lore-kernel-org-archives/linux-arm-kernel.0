From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 24 May 2016 15:19:14 +0200
Subject: [PATCH 0/3] clk: samsung: add Exynos5433 CPU clocks
Message-ID: <1464095957-25851-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following patches add a support for CPU clocks for Exynos5433.

Please note that for full cpufreq-dt support there are also DTS and
cpufreq-dt-platdev changes needed.  They will be sent separately
later.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (3):
  clk: samsung: exynos5433: prepare for adding CPU clocks
  clk: samsung: cpu: prepare for adding Exynos5433 CPU clocks
  clk: samsung: exynos5433: add CPU clocks configuration data and
    instantiate CPU clocks

 drivers/clk/samsung/clk-cpu.c        | 131 +++++++++++++++++++++++++++++-
 drivers/clk/samsung/clk-cpu.h        |   4 +-
 drivers/clk/samsung/clk-exynos5433.c | 149 +++++++++++++++++++++++++++--------
 drivers/clk/samsung/clk.c            |  12 +--
 drivers/clk/samsung/clk.h            |   4 +
 5 files changed, 258 insertions(+), 42 deletions(-)

-- 
1.9.1
