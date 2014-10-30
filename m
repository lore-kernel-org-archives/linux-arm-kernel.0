From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 30 Oct 2014 12:50:09 -0700
Subject: [GIT PULL] Broadcom Cygnus SoC defconfig changes
Message-ID: <1414698612-26216-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  http://github.com/brcm/linux.git tags/arm-soc/for-3.18/cygnus-defconfig-v9

for you to fetch changes up to aa0204801143ee2d47e9e8dd5f39cdddd5613b4b:

  ARM: multi_v7_defconfig: Enable Broadcom Cygnus (2014-10-30 11:01:35 -0700)

----------------------------------------------------------------
This patchset contains initial support for Broadcom's Cygnus SoC based on our
iProc architecture. Initial support is minimal and includes just the mach
platform code, clock driver, and a basic device tree configuration. Peripheral
drivers will be submitted soon, as will device tree configurations for other
Cygnus board variants.

These are the defconfig parts of the changes

----------------------------------------------------------------
Jonathan Richardson (1):
      ARM: cygnus defconfig : Initial defconfig for Broadcom Cygnus SoC

Ray Jui (1):
      ARM: multi_v7_defconfig: Enable Broadcom Cygnus

Scott Branden (1):
      ARM: bcm_defconfig/multi_v7_defconfig: remove one level of menu from Kconfig

 arch/arm/configs/bcm_cygnus_defconfig | 237 ++++++++++++++++++++++++++++++++++
 arch/arm/configs/bcm_defconfig        |   3 +-
 arch/arm/configs/multi_v7_defconfig   |  21 ++-
 3 files changed, 259 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/configs/bcm_cygnus_defconfig
