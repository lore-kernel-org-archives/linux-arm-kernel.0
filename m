From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Dec 2017 20:18:56 +0100
Subject: [GIT PULL 1/5] dt-bindings: Updates for v4.16-rc1
Message-ID: <20171220191900.757-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.16-dt-bindings

for you to fetch changes up to 029ab5eaf091ce5eaa1f3017f66fd1d10f431d61:

  dt-bindings: memory: Add Tegra186 support (2017-12-13 12:53:43 +0100)

Thanks,
Thierry

----------------------------------------------------------------
dt-bindings: Updates for v4.16-rc1

This contains a set of patches that extend existing bindings with support
for Tegra186.

----------------------------------------------------------------
Thierry Reding (2):
      dt-bindings: misc: Add Tegra186 MISC registers bindings
      dt-bindings: memory: Add Tegra186 support

 .../memory-controllers/nvidia,tegra30-mc.txt       |   2 +
 .../bindings/misc/nvidia,tegra186-misc.txt         |  12 +++
 include/dt-bindings/memory/tegra186-mc.h           | 111 +++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/nvidia,tegra186-misc.txt
 create mode 100644 include/dt-bindings/memory/tegra186-mc.h
