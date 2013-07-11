From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Jul 2013 11:05:33 +0200
Subject: [GIT PULL] ux500 defconfig updates
Message-ID: <CACRpkdaczQWVv2S48bxRT+0NoMvmjgj5_Tf7cxOC-8xj+TnuTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

these are some defconfig patches that can be pulled in now that all the new
stuff from various trees has percolated up to Torvalds.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-defconfig-for-arm-soc

for you to fetch changes up to cbe8933143a62e0ced2d48183cdbdbdc38659338:

  ARM: ux500: Enable HIGHMEM in the u8500 defconfig (2013-06-04 11:18:54 +0200)

----------------------------------------------------------------
Ux500 defconfig changes:
- Update base due to different Kconfig changes
- Select watchdog, MUSB, Ux500 ALSA SoC, various MMC/SD
  features and enable highmem

----------------------------------------------------------------
Fabio Baltieri (2):
      ARM: ux500: select WATCHDOG and MUSB for ux500
      ARM: ux500: select SND_SOC_UX500 for ux500

Lee Jones (1):
      ARM: ux500: Enable HIGHMEM in the u8500 defconfig

Linus Walleij (1):
      ARM: ux500: update defconfig base

Ulf Hansson (1):
      ARM: ux500: Update MMC configs for u8500 defconfig

 arch/arm/configs/u8500_defconfig | 44 +++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 19 deletions(-)
