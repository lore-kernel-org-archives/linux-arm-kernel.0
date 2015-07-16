From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 16 Jul 2015 16:13:46 -0700
Subject: [GIT PULL] Broadcom Device Tree changes for 4.3 (part 1)
Message-ID: <1437088427-31176-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-4.3/dts

for you to fetch changes up to 0dfc7f687917a93175d469a2dc1254fd2f77fb63:

  ARM: BCM5301X: Enable UART0 on tested devices (2015-07-07 18:08:57 -0700)

----------------------------------------------------------------
This pull request contains two changes:

- Ray adds the relevant clocks device tree nodes for Cygnus SoCs

- Rafal enables UART0 on BCM5301X routers where it has been verified to work
  correctly

----------------------------------------------------------------
Rafa? Mi?ecki (1):
      ARM: BCM5301X: Enable UART0 on tested devices

Ray Jui (1):
      ARM: dts: enable clock support for Broadcom Cygnus

 arch/arm/boot/dts/bcm-cygnus-clock.dtsi            | 89 +++++++++++++++-------
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |  4 +
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       |  4 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts        | 14 +---
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |  4 +
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts |  4 +
 6 files changed, 81 insertions(+), 38 deletions(-)
