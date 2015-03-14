From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 13 Mar 2015 17:08:48 -0700
Subject: [GIT PULL] Broadcom Device Tree changes for 4.1 #2
Message-ID: <1426291728-22915-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7875b470c9d80dff2d58ae9692adb3a2b5814a89:

  ARM: BCM5301X: Fix default state of power LEDs on Netgear R6250 (2015-03-06 22:26:48 -0800)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-4.1/devicetree-part-2

for you to fetch changes up to cd590b50a9367b52520f6866b27f72317bb1a07e:

  ARM: dts: enable PCIe support for Cygnus (2015-03-13 09:20:47 -0700)

----------------------------------------------------------------
This pull request contains the following changes from Ray for Cygnus SoCs:

- enable IOMUX, required for pinmux/pinctrl
- enable GPIO, required for the GPIO driver
- enable GPIO hook detection for BCM911360-based phone designs
- enable PCIe controller for the bcm958300k designs

----------------------------------------------------------------
Ray Jui (4):
      ARM: dts: enable IOMUX for Broadcom Cygnus
      ARM: dts: enable GPIO for Broadcom Cygnus
      ARM: dts: cygnus: enable GPIO based hook detection
      ARM: dts: enable PCIe support for Cygnus

 arch/arm/boot/dts/bcm-cygnus.dtsi      | 78 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm911360_entphn.dts | 13 ++++++
 arch/arm/boot/dts/bcm958300k.dts       |  8 ++++
 3 files changed, 99 insertions(+)
