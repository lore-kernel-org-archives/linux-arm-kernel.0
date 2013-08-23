From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Aug 2013 15:14:05 +0200
Subject: [GIT PULL] late ux500 changes for v3.12
Message-ID: <CACRpkdYOoG87uvgB5e4DdVJqrzFwOVRv6pgiUq2P-zz_gxPTCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a late pull request for some cleanup for ux500 to be pulled
into the next-soc branch (this is based on the same branch as the
previous pull request for ux500-core).

Should be harmless: two fixes that would have gone into the -rc:s
anyway, and a cleanout of totally unused code.

Please pull it in.

Yours,
Linus Walleij


The following changes since commit 0a429fd15ecb05d7d5fa8eb4adaff69c7a00984b:

  ARM: ux500: set coherent_dma_mask for dma40 (2013-08-19 22:49:25 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-core-for-arm-soc-2

for you to fetch changes up to 1e66a3da4f7d73c027200fb18bb452fbde17fbd7:

  ARM: ux500: fix up the I2C devices (2013-08-20 13:58:25 +0200)

----------------------------------------------------------------
Ux500 core changes for ARM SoC:
- Cleanup from Julia Lawall
- Clean out old pin definitions
- Fix the I2C devices

----------------------------------------------------------------
Julia Lawall (1):
      arch/arm/mach-ux500/cpu-db8500.c: Avoid using ARRAY_AND_SIZE(e)
as a function argument

Linus Walleij (2):
      ARM: ux500: delete oldschool pin defines
      ARM: ux500: fix up the I2C devices

 arch/arm/mach-ux500/board-mop500-audio.c |   1 -
 arch/arm/mach-ux500/board-mop500-pins.c  |   1 -
 arch/arm/mach-ux500/board-mop500.c       |  33 +-
 arch/arm/mach-ux500/cpu-db8500.c         |   3 +-
 arch/arm/mach-ux500/pins-db8500.h        | 746 -------------------------------
 5 files changed, 15 insertions(+), 769 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/pins-db8500.h
