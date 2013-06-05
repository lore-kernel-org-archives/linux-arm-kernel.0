From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 5 Jun 2013 17:08:25 +0300
Subject: [PATCH 0/4] Override bits for PLLM
Message-ID: <1370441329-8619-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PLLM has override bits on Tegra30 and Tegra114. This patchset implements
support for them for both Tegra30 and Tegra114.

Peter De Schrijver (4):
  CHROMIUM: clk: tegra: Add fields for override bits
  CHROMIUM: clk: tegra: override bits for Tegra114 PLLM
  CHROMIUM: clk: tegra: override bits for Tegra30 PLLM
  CHROMIUM: clk: tegra: Use override bits when needed

 drivers/clk/tegra/clk-pll.c      |   82 ++++++++++++++++++++++---------------
 drivers/clk/tegra/clk-tegra114.c |   15 +++++++
 drivers/clk/tegra/clk-tegra30.c  |   18 ++++++++
 drivers/clk/tegra/clk.h          |    8 ++++
 4 files changed, 90 insertions(+), 33 deletions(-)

-- 
1.7.7.rc0.72.g4b5ea.dirty
