From: dhdang@apm.com (Duc Dang)
Date: Thu, 17 Sep 2015 16:38:35 -0700
Subject: [GIT PULL] ARM64: APM X-Gene 1 and X-Gene 2 DTS updates for 4.4
Message-ID: <CADaLNDmeBz69eoU4PO6cAf2cKCQwVCORcXMUf5xdODJVUfb+Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.4-1

for you to fetch changes up to 1d8d53b62d80dc3a6ae1483891e7d840cd7a51bd:

  arm64: dts: Add poweroff device nodes for APM X-Gene 2 platform
(2015-09-16 12:04:25 -0700)

----------------------------------------------------------------
X-Gene DTS changes queued for v4.4

----------------------------------------------------------------
Duc Dang (4):
      MAINTAINERS: Add Applied Micro (APM) X-Gene Device Tree maintainer
      arm64: dts: Add X-Gene v2 reboot driver dts node
      arm64: dts: Add APM X-Gene 2 standby GPIO controller DTS entries
      arm64: dts: Add poweroff device nodes for APM X-Gene 2 platform

Feng Kan (5):
      Documentation: arm64: add SCU dts binding documentation to linux kernel
      arm64: dts: Add X-Gene reboot driver dts node
      arm64: dts: add APM Merlin Board device tree
      Documentation: arm: pmu: Add Potenza PMU binding
      arm64: dts: Add PMU node for APM X-Gene Storm SOC

Tai Nguyen (1):
      power: reset: Add syscon poweroff device node for APM X-Gene platform

 Documentation/devicetree/bindings/arm/apm/scu.txt |  17 ++
 Documentation/devicetree/bindings/arm/pmu.txt     |   1 +
 MAINTAINERS                                       |   5 +
 arch/arm64/boot/dts/apm/Makefile                  |   1 +
 arch/arm64/boot/dts/apm/apm-merlin.dts            |  72 ++++++
 arch/arm64/boot/dts/apm/apm-mustang.dts           |  12 +
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi        | 271 ++++++++++++++++++++++
 arch/arm64/boot/dts/apm/apm-storm.dtsi            |  17 ++
 8 files changed, 396 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/apm/scu.txt
 create mode 100644 arch/arm64/boot/dts/apm/apm-merlin.dts
 create mode 100644 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
