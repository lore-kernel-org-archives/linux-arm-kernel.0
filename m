From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 12 Nov 2014 13:04:24 -0800
Subject: [GIT PULL 3.19] Broadcom Cygnus SoC Device Tree changes
In-Reply-To: <1415826266-6867-1-git-send-email-f.fainelli@gmail.com>
References: <1415826266-6867-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1415826266-6867-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  http://github.com/brcm/linux.git tags/arm-soc/for-3.19/cygnus-dts-v2

for you to fetch changes up to c9ad7bc5fe3c57c8c817fcb1bd264a02176a40c4:

  ARM: dts: Enable Broadcom Cygnus SoC (2014-11-11 22:30:42 -0800)

----------------------------------------------------------------
This pull request contains the Broadcom Cygnus Device Tree changes:

- binding documentation for the SoC and clock
- cygnus SoC and clock dtsi files
- DTS for Cygnus Entreprise phone, BCM911360K and BCM958300K

----------------------------------------------------------------
Jonathan Richardson (1):
      dt-bindings: Document Broadcom Cygnus SoC and clocks

Scott Branden (1):
      ARM: dts: Enable Broadcom Cygnus SoC

 .../devicetree/bindings/arm/bcm/cygnus.txt         |  31 +++++
 .../devicetree/bindings/clock/bcm-cygnus-clock.txt |  34 +++++
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/bcm-cygnus-clock.dtsi            |  91 ++++++++++++++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  | 140 +++++++++++++++++++++
 arch/arm/boot/dts/bcm911360_entphn.dts             |  53 ++++++++
 arch/arm/boot/dts/bcm911360k.dts                   |  53 ++++++++
 arch/arm/boot/dts/bcm958300k.dts                   |  53 ++++++++
 8 files changed, 458 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/cygnus.txt
 create mode 100644 Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt
 create mode 100644 arch/arm/boot/dts/bcm-cygnus-clock.dtsi
 create mode 100644 arch/arm/boot/dts/bcm-cygnus.dtsi
 create mode 100644 arch/arm/boot/dts/bcm911360_entphn.dts
 create mode 100644 arch/arm/boot/dts/bcm911360k.dts
 create mode 100644 arch/arm/boot/dts/bcm958300k.dts
