From: mporter@linaro.org (Matt Porter)
Date: Thu, 6 Mar 2014 01:20:40 -0500
Subject: [GIT PULL] ARM: mach-bcm soc updates for 3.15
Message-ID: <20140306062040.GA29526@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://github.com/broadcom/mach-bcm tags/armsoc/for-3.15/soc-2

for you to fetch changes up to fdf4850cb5b2e5e549a18b8b41abb001bfb19e9c:

  ARM: BCM5301X: workaround suppress fault (2014-03-06 00:36:04 -0500)

----------------------------------------------------------------
ARM: mach-bcm soc updates for 3.15

- add BCM5301x support
- remove GENERIC_TIME

----------------------------------------------------------------
Hauke Mehrtens (3):
      ARM: BCM5301X: initial support for the BCM5301X/BCM470X SoCs with ARM CPU
      ARM: BCM5301X: add early debugging support
      ARM: BCM5301X: workaround suppress fault

Richard Weinberger (1):
      ARM: mach-bcm: Remove GENERIC_TIME

 Documentation/devicetree/bindings/arm/bcm4708.txt |  8 +++
 MAINTAINERS                                       |  8 +++
 arch/arm/Kconfig.debug                            |  7 +++
 arch/arm/configs/multi_v7_defconfig               |  1 +
 arch/arm/mach-bcm/Kconfig                         | 27 +++++++++-
 arch/arm/mach-bcm/Makefile                        |  1 +
 arch/arm/mach-bcm/bcm_5301x.c                     | 61 +++++++++++++++++++++++
 7 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm4708.txt
 create mode 100644 arch/arm/mach-bcm/bcm_5301x.c
