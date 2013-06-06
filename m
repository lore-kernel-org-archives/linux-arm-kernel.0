From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 6 Jun 2013 13:47:27 +0300
Subject: [PATCH v2 0/4] Override bits for PLLM
Message-ID: <1370515677-6807-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PLLM has override bits on Tegra30 and Tegra114. This patchset implements
support for them for both Tegra30 and Tegra114.

Changes since v1:
 * Remove some stray lines from 'clk: tegra: override bits for Tegra114 PLLM'

Peter De Schrijver (4):
  clk: tegra: Add fields for override bits
  clk: tegra: override bits for Tegra114 PLLM
  clk: tegra: override bits for Tegra30 PLLM
  clk: tegra: Use override bits when needed

 drivers/clk/tegra/clk-pll.c      |   82 ++++++++++++++++++++++---------------
 drivers/clk/tegra/clk-tegra114.c |    9 ++++
 drivers/clk/tegra/clk-tegra30.c  |   18 ++++++++
 drivers/clk/tegra/clk.h          |    8 ++++
 4 files changed, 84 insertions(+), 33 deletions(-)

-- 
1.7.7.rc0.72.g4b5ea.dirty
