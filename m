From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 4 May 2012 18:18:04 +0000
Subject: [GIT PULL] DaVinci clean-up for v3.5
Message-ID: <DF0F476B391FA8409C78302C7BA518B63E9FFED3@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the following two DaVinci clean-up patches?

Thanks,
Sekhar

The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:

  Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git tags/v3.5-cleanup

for you to fetch changes up to 04fd232beac094a8ba89fe310d5cdcf6cecb97e2:

  ARM: davinci: implement DEBUG_LL port choice (2012-04-27 23:22:08 +0530)

----------------------------------------------------------------
DaVinci clean-up for v3.5

This pull request implements DEBUG_LL port choice for DaVinci and
improves code readability by using for_each_set_bit_from in DMA
driver.

----------------------------------------------------------------
Akinobu Mita (1):
      arm: davinci: use for_each_set_bit_from

Uwe Kleine-K?nig (1):
      ARM: davinci: implement DEBUG_LL port choice

 arch/arm/Kconfig.debug                           |   29 +++++++++++
 arch/arm/mach-davinci/dma.c                      |    6 +--
 arch/arm/mach-davinci/include/mach/debug-macro.S |   58 ++++++++--------------
 arch/arm/mach-davinci/include/mach/hardware.h    |    2 +-
 arch/arm/mach-davinci/include/mach/serial.h      |   10 ----
 arch/arm/mach-davinci/include/mach/uncompress.h  |   30 ++++-------
 6 files changed, 63 insertions(+), 72 deletions(-)
