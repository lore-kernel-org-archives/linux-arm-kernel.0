From: nsekhar@ti.com (Nori, Sekhar)
Date: Sat, 17 Sep 2011 17:21:10 +0530
Subject: [GIT PULL] davinci features for v3.2 merge windiow
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302575A0DD7@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following feature for v3.2 merge
window. It adds TI WLAN support on AM18x board.

Thanks,
Sekhar

The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:
  Linus Torvalds (1):
        Linux 3.1-rc6

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git v3.2/features

Ido Yariv (4):
      ARM: davinci: DA850: Add MMC/SD1 pinmux configuration
      ARM: davinci: DA850: Add GPIO pinmux configuration for wl1271
      mmc: davinci: Add support for set_power callback
      ARM: davinci: AM18x: Add wl1271/wlan support

 arch/arm/mach-davinci/Kconfig            |   10 +++
 arch/arm/mach-davinci/board-da850-evm.c  |  114 ++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/da850.c            |    9 +++
 arch/arm/mach-davinci/include/mach/mmc.h |    3 +
 arch/arm/mach-davinci/include/mach/mux.h |   10 +++
 drivers/mmc/host/davinci_mmc.c           |   13 ++++
 6 files changed, 159 insertions(+), 0 deletions(-)
