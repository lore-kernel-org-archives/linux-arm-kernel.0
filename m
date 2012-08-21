From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Aug 2012 08:16:13 +0200
Subject: [GIT PULL] ux500 fixes
Message-ID: <CACRpkdZeTb35naqs7UXo127syN7iPgsHUokRE7B=ER8iJRNhmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

here are two audio fixes from Lee Jones for ux500 for the -rc series.
Using a signed tag now!

Please pull them in,
Linus Walleij

The following changes since commit d9875690d9b89a866022ff49e3fcea892345ad92:

  Linux 3.6-rc2 (2012-08-16 14:51:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-fixes-v3.6-rc2

for you to fetch changes up to 46a8b9837da20206c6daca11949485fab7b6e875:

  ARM: ux500: Ensure probing of Audio devices when Device Tree is
enabled (2012-08-17 11:21:30 +0200)

----------------------------------------------------------------
Here are two audio fixes for the ux500 found by Lee Jones.

----------------------------------------------------------------
Lee Jones (2):
      ARM: ux500: Fix merge error, no matching driver name for 'snd_soc_u8500'
      ARM: ux500: Ensure probing of Audio devices when Device Tree is enabled

 arch/arm/mach-ux500/board-mop500-msp.c | 10 +++++-----
 arch/arm/mach-ux500/board-mop500.c     |  4 ++++
 2 files changed, 9 insertions(+), 5 deletions(-)
