From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  9 Mar 2015 10:38:36 -0700
Subject: [GIT PULL] Broadcom Device Tree changes for 4.1 #1
Message-ID: <1425922716-4213-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-4.1/devicetree

for you to fetch changes up to 7875b470c9d80dff2d58ae9692adb3a2b5814a89:

  ARM: BCM5301X: Fix default state of power LEDs on Netgear R6250 (2015-03-06 22:26:48 -0800)

----------------------------------------------------------------
This pull request contains the following Broadcom SoCs Device Tree changes:

- Jonathan adds support for the Broadcom Cygnus BCM958305K board

- Rafal adds support for Netgear R8000 and fixes the default for power LEDs
  on Netgear R6250

----------------------------------------------------------------
Jonathan Richardson (1):
      ARM: dts: Enable Broadcom Cygnus BCM958305K

Rafa? Mi?ecki (2):
      ARM: BCM5301X: Add DT for Netgear R8000
      ARM: BCM5301X: Fix default state of power LEDs on Netgear R6250

 arch/arm/boot/dts/Makefile                  |  6 ++-
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts |  4 +-
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts | 77 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958305k.dts            | 53 ++++++++++++++++++++
 4 files changed, 136 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm4709-netgear-r8000.dts
 create mode 100644 arch/arm/boot/dts/bcm958305k.dts
