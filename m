From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 30 Oct 2014 12:50:10 -0700
Subject: [GIT PULL] Broadcom Cygnus SoC Device Tree changes
In-Reply-To: <1414698612-26216-1-git-send-email-f.fainelli@gmail.com>
References: <1414698612-26216-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1414698612-26216-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  http://github.com/brcm/linux.git tags/arm-soc/for-3.18/cygnus-dts-v9

for you to fetch changes up to 8872fc22c2670cde338ab92be4a8e9ebad8e53e6:

  ARM: dts: Enable Broadcom Cygnus SoC (2014-10-30 11:05:55 -0700)

----------------------------------------------------------------
This patchset contains initial support for Broadcom's Cygnus SoC based on our
iProc architecture. Initial support is minimal and includes just the mach
platform code, clock driver, and a basic device tree configuration. Peripheral
drivers will be submitted soon, as will device tree configurations for other
Cygnus board variants.

These are the Device Tree changes

----------------------------------------------------------------
Jonathan Richardson (1):
      dt-bindings: Document Broadcom Cygnus SoC and clocks

Scott Branden (1):
      ARM: dts: Enable Broadcom Cygnus SoC

 .../devicetree/bindings/arm/bcm/cygnus.txt         |  31 +++++++
 .../devicetree/bindings/clock/bcm-cygnus-clock.txt |  34 +++++++
 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/bcm-cygnus-clock.dtsi            |  73 +++++++++++++++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  | 100 +++++++++++++++++++++
 arch/arm/boot/dts/bcm911360_entphn.dts             |  32 +++++++
 arch/arm/boot/dts/bcm911360k.dts                   |  32 +++++++
 arch/arm/boot/dts/bcm958300k.dts                   |  32 +++++++
 8 files changed, 338 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/cygnus.txt
 create mode 100644 Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt
 create mode 100644 arch/arm/boot/dts/bcm-cygnus-clock.dtsi
 create mode 100644 arch/arm/boot/dts/bcm-cygnus.dtsi
 create mode 100644 arch/arm/boot/dts/bcm911360_entphn.dts
 create mode 100644 arch/arm/boot/dts/bcm911360k.dts
 create mode 100644 arch/arm/boot/dts/bcm958300k.dts
