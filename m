From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 1 Nov 2016 11:02:20 +0800
Subject: [PATCH 0/3] imx: add imx6ull support
Message-ID: <1477969343-19887-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

In this series, it adds support for imx6ull SoC which is a derived SoC
from imx6ul, and imx6ull is pin-to-pin compatible with imx6ul, the
basic functions are tested at imx6ull evk.

Bai Ping (1):
  clk: imx: clk-imx6ul: add clk support for imx6ull

Peter Chen (2):
  ARM: imx6u: add imx6ull support
  ARM: imx: mach-imx6ul: add imx6ull support

 arch/arm/boot/dts/Makefile               |   3 +-
 arch/arm/boot/dts/imx6u-14x14-evk.dts    | 475 ++++++++++++++++
 arch/arm/boot/dts/imx6u-14x14-evk.dtsi   | 487 ++++++++++++++++
 arch/arm/boot/dts/imx6u.dtsi             | 942 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-14x14-evk.dts   | 479 +---------------
 arch/arm/boot/dts/imx6ul.dtsi            | 936 +-----------------------------
 arch/arm/boot/dts/imx6ull-14x14-evk.dts  |  17 +
 arch/arm/boot/dts/imx6ull-pinfunc.h      |  57 ++
 arch/arm/boot/dts/imx6ull.dtsi           |  10 +
 arch/arm/mach-imx/mach-imx6ul.c          |   3 +-
 drivers/clk/imx/clk-imx6ul.c             |  74 ++-
 include/dt-bindings/clock/imx6ul-clock.h |  15 +-
 12 files changed, 2072 insertions(+), 1426 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6u-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6u-14x14-evk.dtsi
 create mode 100644 arch/arm/boot/dts/imx6u.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx6ull.dtsi

-- 
2.7.4
