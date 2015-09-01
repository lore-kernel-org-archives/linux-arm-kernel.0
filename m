From: dhdang@apm.com (Duc Dang)
Date: Tue, 1 Sep 2015 15:20:06 -0700
Subject: [GIT PULL] ARM64: APM X-Gene 1 and X-Gene 2 DTS updates for 4.3
Message-ID: <CADaLNDmZiykNwpU2wY8=Dk6epUWGt4Xu8R6eNQ+_u7dc14Et9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

The following changes since commit 74d33293e467df61de1b1d8b2fbe29e550dec33b:

  Linux 4.2-rc5 (2015-08-02 18:34:55 -0700)

are available in the git repository at:

  https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.3-1

for you to fetch changes up to 28376033baac2f0c2892eafd471b92ab28385d91:

  arm64: dts: Add poweroff device nodes for APM X-Gene 2 platform
(2015-09-01 13:42:16 -0700)

----------------------------------------------------------------
X-Gene 1 and X-Gene 2 platforms DTS changes queued for 4.3

----------------------------------------------------------------
Duc Dang (5):
      MAINTAINERS: Add Applied Micro (APM) X-Gene Device Tree maintainer
      arm64: dts: Add X-Gene v2 reboot driver dts node
      Merge branch 'xgene_pmu' into xgene-next
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
