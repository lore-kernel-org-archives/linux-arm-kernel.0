From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 21:04:28 +0200
Subject: [GIT PULL] Two ux500 fixes for the v3.10 series
Message-ID: <CACRpkdYeWi2cx2weXao9=2f78eM0_J=gK-8o6gKjcG7pjYFAxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are two ux500 fixes for the v3.10 series, please pull
them in. Since -rc1 is not out this is based on Torvald's
HEAD from yesterday.

Yours,
Linus Walleij

The following changes since commit ce857229e0c3adc211944a13a5579ef84fd7b4af:

  ipc: fix GETALL/IPC_RM race for sysv semaphores (2013-05-02 19:51:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-fixes-for-v3.10-1

for you to fetch changes up to 9b7a2104e7e5dd02210ac26f5dc488ceb29778f7:

  ARM: ux500: Rid ignored return value of regulator_enable() compiler
warning (2013-05-03 10:27:12 +0200)

----------------------------------------------------------------
Two ux500 fixes for the v3.10 series:
- SoC ID fix
- Fix errorpath for proximity regulator

----------------------------------------------------------------
Fabio Baltieri (1):
      ARM: ux500: read the correct soc_id number

Lee Jones (1):
      ARM: ux500: Rid ignored return value of regulator_enable()
compiler warning

 arch/arm/mach-ux500/board-mop500.c | 4 ++--
 arch/arm/mach-ux500/cpu-db8500.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
