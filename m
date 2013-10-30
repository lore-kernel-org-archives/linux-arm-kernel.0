From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 30 Oct 2013 02:47:52 +0200
Subject: pull request for Tegra clock rework and Tegra124 clock support
In-Reply-To: <20131023084631.GG22111@tbergstrom-lnx.Nvidia.com>
References: <20131021135638.GA10943@tbergstrom-lnx.Nvidia.com>
 <20131022101904.7554.73999@quantum>
 <20131023084631.GG22111@tbergstrom-lnx.Nvidia.com>
Message-ID: <20131030004752.GH22111@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

This is an update to the previous pull request which fixes some late bugs.

Thanks,

Peter.

The following changes since commit 6c984fc8c6314596c302bbecf79dc59d9f98f348:

  clk: tegra124: add suspend/resume function for tegra_cpu_car_ops (2013-10-21 16:39:24 +0300)

are available in the git repository at:
  git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git tegra-clk-tegra124-0

Mikko Perttunen (1):
      clk: tegra114: Initialize clocks needed for HDMI

Peter De Schrijver (1):
      clk: tegra: use pll_ref as the pll_e parent

Thierry Reding (2):
      clk: tegra: Initialize secondary gr3d clock on Tegra30
      clk: tegra: Properly setup PWM clock on Tegra30

 drivers/clk/tegra/clk-pll.c      |    7 ++++---
 drivers/clk/tegra/clk-tegra114.c |    5 ++++-
 drivers/clk/tegra/clk-tegra30.c  |    5 ++++-
 3 files changed, 12 insertions(+), 5 deletions(-)
