From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Apr 2012 09:36:02 +0800
Subject: [GIT PULL] mxs: device tree support for v3.5
Message-ID: <20120405013556.GI7264@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the mxs basic device tree support for -next, so that people
can start playing and contributing mxs device tree conversion.  Thanks.

Regards,
Shawn

---
The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/dt

Dong Aisheng (1):
      ARM: imx28: add basic dt support

 Documentation/devicetree/bindings/arm/fsl.txt |    4 +
 arch/arm/boot/dts/imx28-evk.dts               |   34 +++
 arch/arm/boot/dts/imx28.dtsi                  |  352 +++++++++++++++++++++++++
 arch/arm/mach-mxs/Kconfig                     |   10 +
 arch/arm/mach-mxs/Makefile                    |    1 +
 arch/arm/mach-mxs/clock-mx28.c                |    4 +
 arch/arm/mach-mxs/devices/Kconfig             |    1 -
 arch/arm/mach-mxs/mach-mxs.c                  |   68 +++++
 8 files changed, 473 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx28-evk.dts
 create mode 100644 arch/arm/boot/dts/imx28.dtsi
 create mode 100644 arch/arm/mach-mxs/mach-mxs.c
