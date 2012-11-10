From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 10 Nov 2012 12:13:39 +0530
Subject: [PATCH 0/8] CLK: SPEAr: Fixes & updates
Message-ID: <cover.1352529508.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

These are fixes for SPEAr clock stuff. Most of them are fixes, but we don't mind
getting them in 3.8.

Deepak Sikri (2):
  CLK: SPEAr1340: Update clock rate table
  CLK: SPEAr: Correct index scanning done for clock synths

Rajeev Kumar (1):
  CLK: SPEAr: Fix dev_id & con_id for multiple clocks

Shiraz Hashim (2):
  CLK: SPEAr13xx: Fix mux clock names
  CLK: SPEAr13xx: fix parent names of multiple clocks

Vipul Kumar Samar (3):
  CLK: SPEAr: Set CLK_SET_RATE_PARENT for few clocks
  CLK: SPEAr: Add missing clocks
  CLK: SPEAr: Remove unused dummy apb_pclk

 drivers/clk/spear/clk-aux-synth.c   |   3 +-
 drivers/clk/spear/clk.c             |   3 +
 drivers/clk/spear/spear1310_clock.c | 106 +++++++++-------
 drivers/clk/spear/spear1340_clock.c | 237 ++++++++++++++++++++++--------------
 drivers/clk/spear/spear3xx_clock.c  | 148 +++++++++++++---------
 drivers/clk/spear/spear6xx_clock.c  |  13 +-
 6 files changed, 306 insertions(+), 204 deletions(-)

-- 
1.7.12.rc2.18.g61b472e
