From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 May 2018 11:30:40 +0200
Subject: [GIT PULL] Ux500 updates for v4.18
Message-ID: <CACRpkdbG9DSRT0iT+YmuUx7vXsUyJo2w8XGxr=-rCxcMnZ2yUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there ARM SoC folks,

here are some Ux500 updates for v4.18. We drop
the experimental silicon in U8540 and U9540 and
tidy up Kconfig a bit.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-machine-arm-soc

for you to fetch changes up to 52b12be584ba554a40ad61d4d07bfbc100ffa1ac:

  ARM: ux500: Cut down Kconfig options (2018-05-04 11:02:52 +0200)

----------------------------------------------------------------
These changes for ux500:
- Drops U8540 and U9540
- Cuts down the Kconfig options due to accumulated simplifications

----------------------------------------------------------------
Linus Walleij (2):
      ARM: ux500: Drop U8540/9540 support
      ARM: ux500: Cut down Kconfig options

 arch/arm/mach-ux500/Kconfig       | 53 ++++++++-------------------------------
 arch/arm/mach-ux500/cpu-db8500.c  | 16 ++----------
 arch/arm/mach-ux500/db8500-regs.h |  4 ---
 3 files changed, 13 insertions(+), 60 deletions(-)
