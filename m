From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 3 Jul 2014 19:17:40 +0300
Subject: pull request for Tegra clock updates for 3.17
Message-ID: <20140703161740.GA6078@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

A few bug fixes for Tegra124 clocks and some updates for the SATA driver


The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:

  Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)

are available in the git repository at:
  git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git tegra-clk-3.17

Mikko Perttunen (2):
      clk: tegra: Enable hardware control of SATA PLL
      clk: tegra: Add SATA clocks to Tegra124 initialization table

Peter De Schrijver (3):
      clk: tegra: fix vi_sensor clocks on Tegra124
      clk: tegra124: init table updates
      clk: tegra: export clock names for debugging

 drivers/clk/tegra/clk-pll.c          |    8 ++++++++
 drivers/clk/tegra/clk-tegra-periph.c |    4 ++--
 drivers/clk/tegra/clk-tegra114.c     |   31 ++++++++++++++++++++++++++++++-
 drivers/clk/tegra/clk-tegra124.c     |   10 +++++++++-
 drivers/clk/tegra/clk.c              |    6 ++++++
 5 files changed, 55 insertions(+), 4 deletions(-)
