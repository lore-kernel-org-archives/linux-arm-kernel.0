From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Oct 2017 13:55:57 +0200
Subject: [GIT PULL 1/7] dt-bindings: Updates for v4.15-rc1
Message-ID: <20171020115603.9828-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.15-dt-bindings

for you to fetch changes up to 3e09b155d58e44e33a699650128f8c6c833cb320:

  dt-bindings: Add bindings for nvidia,tegra186-bpmp-thermal (2017-10-19 16:26:22 +0200)

Thanks,
Thierry

----------------------------------------------------------------
dt-bindings: Updates for v4.15-rc1

This contains the addition of a clock alias which will be used to fix
the implementation of the SOR1 clock.

Also included are the bindings for the Tegra186 BPMP thermal driver, a
prerequisite for both the driver and device tree changes.

----------------------------------------------------------------
Mikko Perttunen (1):
      dt-bindings: Add bindings for nvidia,tegra186-bpmp-thermal

Thierry Reding (1):
      dt-bindings: clock: tegra: Add sor1_out clock

 .../thermal/nvidia,tegra186-bpmp-thermal.txt       | 32 ++++++++++++++++++++++
 include/dt-bindings/clock/tegra210-car.h           |  1 +
 .../dt-bindings/thermal/tegra186-bpmp-thermal.h    | 14 ++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
 create mode 100644 include/dt-bindings/thermal/tegra186-bpmp-thermal.h
