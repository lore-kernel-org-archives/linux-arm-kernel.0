From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 29 Jun 2018 19:23:37 +0530
Subject: [GIT PULL] DaVinci fixes for v4.18
Message-ID: <341001c8-3881-5d02-2971-77c7e1adf61a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.18

for you to fetch changes up to 3eb1b955cd7ed1e621ace856710006c2a8a7f231:

  ARM: dts: da850: Fix interrups property for gpio (2018-06-27 17:38:44 +0530)

----------------------------------------------------------------
This fixes polarity of SD card write-protect pin on DA850 EVM
and fixes interrupt property for DA850 SoC GPIO as defined in
device-tree.

Both of these are not introduced with v4.18 merge but have
existed prior.

----------------------------------------------------------------
Adam Ford (1):
      ARM: davinci: board-da850-evm: fix WP pin polarity for MMC/SD

Keerthy (1):
      ARM: dts: da850: Fix interrups property for gpio

 arch/arm/boot/dts/da850.dtsi            | 6 +-----
 arch/arm/mach-davinci/board-da850-evm.c | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)
