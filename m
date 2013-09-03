From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 3 Sep 2013 16:31:30 +0300
Subject: [PATCH 0/4] Introduce table driven initializations
Message-ID: <1378215105-12145-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces a table driven initialization method for the
audio, PMC and gate clocks. It's similar to the table we already have for
the periph clocks.

Peter De Schrijver (4):
  clk: tegra: simplify periph clock data
  clk: tegra: convert Tegra114 gate clocks to table
  clk: tegra114: table driven audio clock init
  clk: tegra114: table driven PMC clock init

 drivers/clk/tegra/clk-tegra114.c |  926 ++++++++++++++++----------------------
 drivers/clk/tegra/clk.h          |   79 ++++
 2 files changed, 455 insertions(+), 550 deletions(-)

-- 
1.7.7.rc0.72.g4b5ea.dirty
