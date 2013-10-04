From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 4 Oct 2013 12:12:39 +0300
Subject: [PATCH 0/5] Tegra124 clock support
Message-ID: <1380878014-22088-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces support for the Tegra124 CAR clocks.
Based on '[PATCH v2 00/12] Introduce common infra for tegra clocks'

Peter De Schrijver (5):
  clk: tegra: Add support for PLLSS
  clk: tegra: Add periph regs bank X
  clk: tegra124: Add common clk IDs to clk-id.h
  clk: tegra124: Add new peripheral clocks
  clk: tegra124: Add support for Tegra124 clocks

 drivers/clk/tegra/Makefile               |    1 +
 drivers/clk/tegra/clk-id.h               |   27 +
 drivers/clk/tegra/clk-pll.c              |  168 +++++
 drivers/clk/tegra/clk-tegra-periph.c     |   61 ++
 drivers/clk/tegra/clk-tegra124.c         | 1206 ++++++++++++++++++++++++++++++
 drivers/clk/tegra/clk.c                  |   10 +
 drivers/clk/tegra/clk.h                  |    7 +
 include/dt-bindings/clock/tegra124-car.h |  342 +++++++++
 8 files changed, 1822 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/tegra/clk-tegra124.c
 create mode 100644 include/dt-bindings/clock/tegra124-car.h

-- 
1.7.7.rc0.72.g4b5ea.dirty
