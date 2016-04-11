From: chanho.min@lge.com (Chanho Min)
Date: Mon, 11 Apr 2016 10:26:56 +0900
Subject: [RESEND PATCH v2 0/4] ARM64:SoC add a new platform,
 LG Electronics's lg1k
Message-ID: <1460338020-28999-1-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an initial series for supporting LG Electronics's lg1k SoCs,
based on ARM Cortex-A53, mainly used for digital TVs.

Chanho Min (4):
  arm64: add Kconfig entry for LG1K SoC family
  arm64: defconfig: enable ARCH_LG1K
  arm64: dts: Add dts files for LG Electronics's lg1312 SoC
  MAINTAINERS: add myself as ARM/LG1K maintainer

 MAINTAINERS                           |    6 +
 arch/arm64/Kconfig.platforms          |    4 +
 arch/arm64/boot/dts/Makefile          |    1 +
 arch/arm64/boot/dts/lg/Makefile       |    5 +
 arch/arm64/boot/dts/lg/lg1312-ref.dts |   36 ++++
 arch/arm64/boot/dts/lg/lg1312.dtsi    |  351 +++++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig          |    1 +
 7 files changed, 404 insertions(+)
 create mode 100644 arch/arm64/boot/dts/lg/Makefile
 create mode 100644 arch/arm64/boot/dts/lg/lg1312-ref.dts
 create mode 100644 arch/arm64/boot/dts/lg/lg1312.dtsi

-- 
1.7.9.5
