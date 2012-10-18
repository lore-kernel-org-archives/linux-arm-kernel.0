From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 18 Oct 2012 18:07:14 +0100
Subject: [GIT PULL] vexpress: drivers for v3.8
Message-ID: <1350580034.4984.21.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Could you, please, pull new Versatile Express related drivers for 3.8?
The hwmon driver is acked by the subsystem maintainer who asked to get
it merged through arm-soc.

Thanks!

Pawel

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-drivers

for you to fetch changes up to 790440bc90fa800ff2a4b8b5046227a2ca32c1b1:

  ARM: vexpress: Reset driver (2012-10-18 17:58:47 +0100)

----------------------------------------------------------------
Pawel Moll (2):
      hwmon: Versatile Express hwmon driver
      ARM: vexpress: Reset driver

 .../devicetree/bindings/hwmon/vexpress.txt         |   23 ++
 Documentation/hwmon/vexpress                       |   34 +++
 arch/arm/mach-vexpress/reset.c                     |  141 ++++++++++++
 drivers/hwmon/Kconfig                              |    8 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/vexpress.c                           |  229 ++++++++++++++++++++
 6 files changed, 436 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/vexpress.txt
 create mode 100644 Documentation/hwmon/vexpress
 create mode 100644 arch/arm/mach-vexpress/reset.c
 create mode 100644 drivers/hwmon/vexpress.c
