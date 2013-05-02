From: b35083@freescale.com (Jingchang Lu)
Date: Thu, 2 May 2013 15:38:03 +0800
Subject: [PATCH V2 0/2] ARM/MVF600: add Freescale Vybrid Family platform and
 development board support This Vybird MVF600 family is a heterogeneous
 dual-core eMPU family combining the ARM Cortex-A5 and Corte-M4 cores. This
 SOC still shares some IPs with Iscale Vybrid Family SOC and Vybrid Tower
 development board.
Message-ID: <1367480285-26159-1-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation/devicetree/bindings/clock/mvf600-clock.txt | 180 ++++++++
arch/arm/boot/dts/Makefile                               |   3 +-
arch/arm/boot/dts/mvf600-pinfunc.h                       | 816 +++++++++++++++++++++++++++++++++++
arch/arm/boot/dts/mvf600-twr.dts                         |  80 ++++
arch/arm/boot/dts/mvf600.dtsi                            | 426 ++++++++++++++++++
arch/arm/mach-imx/Kconfig                                |  15 +
arch/arm/mach-imx/Makefile                               |   3 +
arch/arm/mach-imx/clk-mvf.c                              | 406 +++++++++++++++++
arch/arm/mach-imx/common.h                               |   1 +
arch/arm/mach-imx/mach-mvf600.c                          | 118 +++++
arch/arm/mach-imx/pit.c                                  | 244 +++++++++++
11 files changed, 2291 insertions(+), 1 deletion(-)
create mode 100644 Documentation/devicetree/bindings/clock/mvf600-clock.txt
create mode 100644 arch/arm/boot/dts/mvf600-pinfunc.h
create mode 100644 arch/arm/boot/dts/mvf600-twr.dts
create mode 100644 arch/arm/boot/dts/mvf600.dtsi
create mode 100644 arch/arm/mach-imx/clk-mvf.c
create mode 100644 arch/arm/mach-imx/mach-mvf600.c
create mode 100644 arch/arm/mach-imx/pit.c
