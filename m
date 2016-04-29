From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Apr 2016 18:21:07 +0200
Subject: [GIT PULL] dt-bindings: gpio: tegra: Add Tegra186 support
Message-ID: <1461946869-26124-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC maintainers,

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.7-gpio

for you to fetch changes up to ec6b925579b40225d58f0374ada0e40a003cde16:

  ARM: tegra: Add DT binding for Tegra186 GPIO controllers (2016-04-22 13:32:29 +0200)

Thanks,
Thierry

----------------------------------------------------------------
dt-bindings: gpio: tegra: Add Tegra186 support

Adds device tree bindings for the GPIO and AON controllers found on the
Tegra186 SoC.

----------------------------------------------------------------
Stephen Warren (2):
      ARM: tegra: Fix naming in GPIO DT binding header
      ARM: tegra: Add DT binding for Tegra186 GPIO controllers

 .../bindings/gpio/nvidia,tegra186-gpio.txt         | 161 +++++++++++++++++++++
 include/dt-bindings/gpio/tegra-gpio.h              |  68 ++++-----
 include/dt-bindings/gpio/tegra186-gpio.h           |  56 +++++++
 3 files changed, 251 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
 create mode 100644 include/dt-bindings/gpio/tegra186-gpio.h
