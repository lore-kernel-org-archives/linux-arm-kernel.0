From: jun.nie@linaro.org (Jun Nie)
Date: Tue,  6 Sep 2016 14:04:18 +0800
Subject: [PATCH v4 0/3] Add ZTE ZX296718 support
Message-ID: <1473141861-5033-1-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in version4:
  - Change dts file name to align with compatible name.
  - Reorder dts nodes with reg address sequence.
  - Move nodes out of soc, which do not have soc simple
    bus address or share soc interrupt.
  - Change some nodes name to align with convention.

Changes in version3:
  - Remove unnecessary flag of gic in dts.

Changes in version2:
  - Use more precise cpu and pmu compatible name in dts.
  - fix minor coding style issue.


Jun Nie (3):
  arm64: add ZTE ZX SoC family
  arm64: dts: Add ZTE ZX296718 SoC dts and Makefile
  arm64: defconfig: enable ZTE ZX related config

 Documentation/devicetree/bindings/arm/zte.txt |  24 +++
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/zte/Makefile              |   5 +
 arch/arm64/boot/dts/zte/zx296718-evb.dts      |  25 +++
 arch/arm64/boot/dts/zte/zx296718.dtsi         | 254 ++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 7 files changed, 315 insertions(+)
 create mode 100644 arch/arm64/boot/dts/zte/Makefile
 create mode 100644 arch/arm64/boot/dts/zte/zx296718-evb.dts
 create mode 100644 arch/arm64/boot/dts/zte/zx296718.dtsi

-- 
1.9.1
