From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Aug 2012 13:38:10 +0200
Subject: [GIT PULL] Ux500 ASIC ID patches
Message-ID: <CACRpkdZ1+vjrTQC9-M9icO7p9POg-zcR_gUpkyemF4da3jny2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

could you please pull the following patch set into ARM SoC as a first
step for the
next merge window. This cleans up, updates and structure the use of some ASIC ID
detection macros so they are understandable and consistent.

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
ux500-core

for you to fetch changes up to 1d3266ecca67066e537fe0e0669bed77d355f886:

  ARM: ux500: add detection for DB8500 ASIC v2.2 (2012-08-09 17:48:45 +0200)

----------------------------------------------------------------
Linus Walleij (4):
      ARM: ux500: delete remnant U5500 macros
      ARM: ux500: add a U8520 detection macro
      ARM: ux500: reform Ux500 family names
      ARM: ux500: add detection for DB8500 ASIC v2.2

 arch/arm/mach-ux500/cache-l2x0.c      |  2 +-
 arch/arm/mach-ux500/cpu-db8500.c      |  2 +-
 arch/arm/mach-ux500/cpu.c             |  2 +-
 arch/arm/mach-ux500/include/mach/id.h | 44
+++++++++++++++-----------------------------
 arch/arm/mach-ux500/platsmp.c         |  2 +-
 5 files changed, 19 insertions(+), 33 deletions(-)

Yours,
Linus Walleij
