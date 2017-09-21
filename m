From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Sep 2017 11:26:54 +0200
Subject: [GIT PULL] EP93xx improvements for v4.15
Message-ID: <CACRpkdYfhRuPLUGaweWzukxRiY0XsJ+DtaWd2OzVLq6daZqeyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a first pull request for EP93xx improvements from
Hartley et al.

These patches have been floating for a while and really need
to land upstream.

Please pull them in where appropriate for v4.15.

Yours,
Linus Walleij

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/ep93xx-for-arm-soc-1

for you to fetch changes up to 7aef828dfc41565f7e2f7af99be8134639d3f769:

  ARM: ep93xx: Add lm70 HWMON sensor to TS-72xx boards (2017-09-21
11:22:04 +0200)

----------------------------------------------------------------
EP93xx patches that have been floating for a while,
converting the platform to sparsemem, using SPI-MMC
and a bit more.

----------------------------------------------------------------
H Hartley Sweeten (4):
      ARM: ep93xx: switch to SPARSEMEM
      ARM: ep93xx: simone: let the mmc_spi driver handle the card detect
      ARM: ep93xx: tidy up TS-72xx Watchdog resources
      ARM: ep93xx: Add lm70 HWMON sensor to TS-72xx boards

 arch/arm/Kconfig              |  2 +-
 arch/arm/mach-ep93xx/simone.c | 54 +++----------------------------------------
 arch/arm/mach-ep93xx/ts72xx.c | 46 +++++++++++++++++++++++++++---------
 arch/arm/mach-ep93xx/ts72xx.h |  3 ---
 4 files changed, 39 insertions(+), 66 deletions(-)
