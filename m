From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jan 2013 13:40:34 +0100
Subject: [GIT PULL] ux500 fixes for the v3.8 series
Message-ID: <CACRpkdYhVbu2S6iD=SRnU1gMRNfau25ihOqoDoXvCrH71seREQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

here are three fixes for the Ux500 that need to go to the -rc:s.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-fixes-for-v3.8

for you to fetch changes up to 579400166a744890b2a67ca21765b5b6dc649441:

  ARM: ux500: Fix u9540 booting issues (2013-01-24 17:05:21 +0100)

----------------------------------------------------------------
- U9540 boot regression fix due to new clock framework
- Configure out the yet instable battery management driver
- Adjust cache initilization per SoC family

----------------------------------------------------------------
Lee Jones (2):
      ARM: ux500: Disable Power Supply and Battery Management by default
      ARM: ux500: Fix u9540 booting issues

Steve Zhan (1):
      ARM: ux500: add spin_unlock(&master_lock).

 arch/arm/configs/u8500_defconfig | 6 +++---
 arch/arm/mach-ux500/cpu.c        | 6 ++----
 arch/arm/mach-ux500/cpuidle.c    | 4 +++-
 3 files changed, 8 insertions(+), 8 deletions(-)
