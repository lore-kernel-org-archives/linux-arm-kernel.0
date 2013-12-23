From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 23 Dec 2013 18:27:05 +0200
Subject: pull request for some small fixes
Message-ID: <20131223162705.GE3378@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 62ce7cd62f534023224912dc9b909963f26a38da:

  clk: tegra: fix __clk_lookup() return value checks (2013-11-28 15:09:22 +0200)

are available in the git repository at:
  git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git clk-tegra-next-1

Peter De Schrijver (1):
      clk: tegra: Add missing Tegra20 fuse clks

Thierry Reding (1):
      clk: tegra: Correct clock number for UARTE

 drivers/clk/tegra/clk-tegra-periph.c |    2 +-
 drivers/clk/tegra/clk-tegra20.c      |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)
