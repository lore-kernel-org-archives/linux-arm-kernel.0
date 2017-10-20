From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Oct 2017 13:56:02 +0200
Subject: [GIT PULL 6/7] arm64: tegra: Device tree changes for v4.15-rc1
In-Reply-To: <20171020115603.9828-1-thierry.reding@gmail.com>
References: <20171020115603.9828-1-thierry.reding@gmail.com>
Message-ID: <20171020115603.9828-6-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.15-arm64-dt

for you to fetch changes up to 15274c232131569b9010634a3f4f129c80c027a3:

  arm64: tegra: Add BPMP thermal sensor to Tegra186 (2017-10-19 16:35:50 +0200)

This pulls in a part of the tegra-for-4.15-dt-bindings tag in order to
resolve a build time dependency.

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Device tree changes for v4.15-rc1

Enables host1x, VIC, PCIe and the BPMP thermal sensor on Tegra186.

----------------------------------------------------------------
Manikanta Maddireddy (2):
      arm64: tegra: Add PCIe node for Tegra186
      arm64: tegra: Enable PCIe on Jetson TX2

Mikko Perttunen (5):
      dt-bindings: Add bindings for nvidia,tegra186-bpmp-thermal
      arm64: tegra: Add #power-domain-cells for BPMP
      arm64: tegra: Add host1x on Tegra186
      arm64: tegra: Add VIC on Tegra186
      arm64: tegra: Add BPMP thermal sensor to Tegra186

Thierry Reding (2):
      dt-bindings: clock: tegra: Add sor1_out clock
      Merge branch 'for-4.15/dt-bindings' into for-4.15/arm64/dt

 .../thermal/nvidia,tegra186-bpmp-thermal.txt       |  32 +++
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |  24 +++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 214 +++++++++++++++++++++
 include/dt-bindings/clock/tegra210-car.h           |   1 +
 .../dt-bindings/thermal/tegra186-bpmp-thermal.h    |  14 ++
 5 files changed, 285 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
 create mode 100644 include/dt-bindings/thermal/tegra186-bpmp-thermal.h
