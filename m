From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Nov 2016 17:17:13 +0100
Subject: [GIT PULL 4/10] bus: Add Tegra GMI support
In-Reply-To: <20161118161719.24153-1-thierry.reding@gmail.com>
References: <20161118161719.24153-1-thierry.reding@gmail.com>
Message-ID: <20161118161719.24153-4-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.10-bus

for you to fetch changes up to 40eb47767852a9122ef99a48f8d208ec6327e07f:

  bus: Add support for Tegra Generic Memory Interface (2016-11-15 17:27:53 +0100)

Thanks,
Thierry

----------------------------------------------------------------
bus: Add Tegra GMI support

This provides a driver to enable the use of the Generic Memory Interface
found on Tegra SoCs that can host various types of high-speed devices.

----------------------------------------------------------------
Mirza Krak (2):
      dt/bindings: Add bindings for Tegra GMI controller
      bus: Add support for Tegra Generic Memory Interface

 .../devicetree/bindings/bus/nvidia,tegra20-gmi.txt | 132 ++++++++++
 drivers/bus/Kconfig                                |   7 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/tegra-gmi.c                            | 284 +++++++++++++++++++++
 4 files changed, 424 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
 create mode 100644 drivers/bus/tegra-gmi.c
