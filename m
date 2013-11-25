From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 25 Nov 2013 15:20:21 +0200
Subject: [PATCH 0/2] Tegra124 clock fixes
Message-ID: <1385385623-8952-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few fixes for Tegra124 clocks. These patches will be squashed into the pull
request I will send out later today, but I wanted to post them here as well
so the changes are known.

Peter De Schrijver (2):
  clk: tegra: fix vi clk for Terga124
  clk: tegra: fix pllcx pdiv for Tegra124

 drivers/clk/tegra/clk-id.h           |    1 +
 drivers/clk/tegra/clk-tegra-periph.c |    8 ++++++++
 drivers/clk/tegra/clk-tegra124.c     |    5 ++++-
 3 files changed, 13 insertions(+), 1 deletions(-)

-- 
1.7.7.rc0.72.g4b5ea.dirty
