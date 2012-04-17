From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Apr 2012 08:39:02 +0200
Subject: [GIT PULL] ux500 fixes for 3.4-rc series
Message-ID: <CACRpkdbixRZb_6uT2M52zQ70Jb-uA0Lzhjy2ZG=g8vrKq9KPZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

These are a few -rc fixes for ux500 collected since the merge window.

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
fixes-for-arm-soc-20120416

for you to fetch changes up to f27962ac68a9b4cf17958522ecd7c10ce2375ee1:

  ARM: ux500: update defconfig (2012-04-16 09:00:53 +0200)

----------------------------------------------------------------
Jonas Aaberg (1):
      ARM: ux500: wake secondary cpu via resched

Lee Jones (1):
      ARM: ux500: Fix unmet direct dependency

Linus Walleij (1):
      ARM: ux500: update defconfig

 arch/arm/configs/u8500_defconfig |    9 ++++-----
 arch/arm/mach-ux500/Kconfig      |    1 +
 arch/arm/mach-ux500/platsmp.c    |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)
