From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 18 Nov 2015 16:09:25 +0100
Subject: [PATCH v9 0/2] Sigma Designs Tango4 port
Message-ID: <564C94A5.4060301@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez (2):
  arm-soc: Import initial tango4 device tree
  arm-soc: Add support for tango4 platforms

 arch/arm/Kconfig                          |   2 +
 arch/arm/Makefile                         |   1 +
 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/tango4-common.dtsi      | 121 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tango4-smp8758.dtsi     |  31 ++++++++
 arch/arm/boot/dts/tango4-vantage-1172.dts |  29 +++++++
 arch/arm/mach-tangox/Kconfig              |  12 +++
 arch/arm/mach-tangox/Makefile             |   2 +
 arch/arm/mach-tangox/setup.c              |  32 ++++++++
 arch/arm/mach-tangox/smc.S                |   9 +++
 arch/arm/mach-tangox/smc.h                |   5 ++
 11 files changed, 246 insertions(+)
 create mode 100644 arch/arm/boot/dts/tango4-common.dtsi
 create mode 100644 arch/arm/boot/dts/tango4-smp8758.dtsi
 create mode 100644 arch/arm/boot/dts/tango4-vantage-1172.dts
 create mode 100644 arch/arm/mach-tangox/Kconfig
 create mode 100644 arch/arm/mach-tangox/Makefile
 create mode 100644 arch/arm/mach-tangox/setup.c
 create mode 100644 arch/arm/mach-tangox/smc.S
 create mode 100644 arch/arm/mach-tangox/smc.h

-- 
2.4.5
