From: jun.nie@linaro.org (Jun Nie)
Date: Thu,  1 Sep 2016 20:51:39 +0800
Subject: [PATCH v3 0/3] Add ZTE ZX296718 support
Message-ID: <1472734302-8986-1-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in version3:
  - Remove unecessary flag of gic in dts.

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
 arch/arm64/boot/dts/zte/zx296718.dts          |  21 +++
 arch/arm64/boot/dts/zte/zx296718.dtsi         | 253 ++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 7 files changed, 310 insertions(+)
 create mode 100644 arch/arm64/boot/dts/zte/Makefile
 create mode 100644 arch/arm64/boot/dts/zte/zx296718.dts
 create mode 100644 arch/arm64/boot/dts/zte/zx296718.dtsi

-- 
1.9.1
