From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 May 2013 16:30:13 +0200
Subject: [GIT PULL] ux500 fixes for the v3.10 series
Message-ID: <CACRpkdY11CLBVTtWcXFDfWjrgfizhK45WnkR8b7CL8JwqQy8pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are two fixes from Lee Jones which hopefully fixes up the
last pieces of fallout from the v3.10 merge window. Description
in the signed tag.

Please pull them in for fixes to Torvalds.

Yours,
Linus Walleij


The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-arm-soc-v3.10-fixes-2

for you to fetch changes up to 67b7c75e1a42f8288450203cd80a26b11dab8582:

  ARM: ux500: Provide supplies for AUX1, AUX2 and AUX3 (2013-05-27
14:08:20 +0200)

----------------------------------------------------------------
Ux500 fixes for v3.10:
- A multiplatform fix making sure ux500_idle_init() is only
  executed on ux500.
- A regulator fix making sure the MMC/SD card regulator is
  not disabled on boot.

----------------------------------------------------------------
Lee Jones (2):
      ARM: ux500: Only configure wake-up reasons on ux500 based platforms
      ARM: ux500: Provide supplies for AUX1, AUX2 and AUX3

 arch/arm/mach-ux500/board-mop500-regulators.c | 3 +++
 arch/arm/mach-ux500/cpuidle.c                 | 4 ++++
 2 files changed, 7 insertions(+)
