From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Sep 2018 22:59:38 +0200
Subject: [GIT PULL 1/5] dt-bindings: Changes for v4.20-rc1
Message-ID: <20180927205942.30878-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.20-dt-bindings

for you to fetch changes up to d9be10edf7d6040468f89824df0dfcfcbf3a693b:

  dt-bindings: Add Tegra PMC pad configuration bindings (2018-08-27 12:21:43 +0200)

Thanks,
Thierry

----------------------------------------------------------------
dt-bindings: Changes for v4.20-rc1

This contains the PMC pad configuration bindings which are used to
control the voltage of various pads found on Tegra chips. Among other
things this is required to enable faster modes on SDHCI.

----------------------------------------------------------------
Aapo Vienamo (1):
      dt-bindings: Add Tegra PMC pad configuration bindings

 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  93 +++++++++++++++++++
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 103 +++++++++++++++++++++
 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 ++++
 3 files changed, 214 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
