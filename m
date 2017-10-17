From: hanetzer@startmail.com (Marty E. Plummer)
Date: Tue, 17 Oct 2017 17:38:51 -0500
Subject: [PATCH v2 0/3] Add support for Hisilicon Hi3521A SoC
Message-ID: <20171017223854.6980-1-hanetzer@startmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patched up with suggestions from Rob Herring, resend.

Marty E. Plummer (3):
  clk: hisilicon: add CRG driver Hi3521A SoC
  arm: hisi: enable Hi3521A SoC
  arm: dts: add Hi3521A dts

 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/hi3521a-rs-dm290e.dts   |  41 ++++
 arch/arm/boot/dts/hi3521a.dtsi            | 308 ++++++++++++++++++++++++++++++
 arch/arm/mach-hisi/Kconfig                |   6 +
 drivers/clk/hisilicon/Kconfig             |   7 +
 drivers/clk/hisilicon/Makefile            |   1 +
 drivers/clk/hisilicon/crg-hi3521a.c       | 196 +++++++++++++++++++
 include/dt-bindings/clock/hi3521a-clock.h |  23 +++
 8 files changed, 584 insertions(+)
 create mode 100644 arch/arm/boot/dts/hi3521a-rs-dm290e.dts
 create mode 100644 arch/arm/boot/dts/hi3521a.dtsi
 create mode 100644 drivers/clk/hisilicon/crg-hi3521a.c
 create mode 100644 include/dt-bindings/clock/hi3521a-clock.h

-- 
2.14.2
