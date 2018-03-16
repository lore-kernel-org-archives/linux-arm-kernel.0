From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 16 Mar 2018 15:18:50 +0100
Subject: [GIT PULL 7/7] arm64: tegra: Device tree changes for v4.17-rc1
In-Reply-To: <20180316141850.4876-1-thierry.reding@gmail.com>
References: <20180316141850.4876-1-thierry.reding@gmail.com>
Message-ID: <20180316141850.4876-7-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.17-arm64-dt

for you to fetch changes up to 0f2754cee38fd2bc42f446d299ff0c53815dc5bd:

  arm64: tegra: Enable AHCI on Jetson TX1 (2018-03-14 17:34:51 +0100)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Device tree changes for v4.17-rc1

Adds initial support for the P2972-0000 development board based on
Tegra194 and enables the AHCI controller on Jetson TX1.

----------------------------------------------------------------
Mikko Perttunen (2):
      arm64: tegra: Add Tegra194 chip device tree
      arm64: tegra: Add device tree for the Tegra194 P2972-0000 board

Preetham Ramchandra (2):
      arm64: tegra: Add SATA node for Tegra210
      arm64: tegra: Enable AHCI on Jetson TX1

 arch/arm64/boot/dts/nvidia/Makefile                |   1 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     | 248 +++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |  16 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           | 344 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   5 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  16 +
 include/dt-bindings/clock/tegra194-clock.h         | 321 +++++++++++++++++++
 include/dt-bindings/gpio/tegra194-gpio.h           |  61 ++++
 include/dt-bindings/power/tegra194-powergate.h     |  35 +++
 include/dt-bindings/reset/tegra194-reset.h         | 152 +++++++++
 10 files changed, 1199 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194.dtsi
 create mode 100644 include/dt-bindings/clock/tegra194-clock.h
 create mode 100644 include/dt-bindings/gpio/tegra194-gpio.h
 create mode 100644 include/dt-bindings/power/tegra194-powergate.h
 create mode 100644 include/dt-bindings/reset/tegra194-reset.h
