From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Apr 2012 09:27:06 +0200
Subject: [GIT PULL] U300 fixes for the 3.4 series
Message-ID: <CACRpkdYnV3em1v8VJ9ukoVN6+-6vRa69pf5d7p8JJ1W=8tbCCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

these are some two accumulated fixes for the U300 platform to be included
in the -rc series for 3.4.

The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:

  Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)

are available in the git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
u300-fixes-for-arm-soc

for you to fetch changes up to 1344500e2d79d09db81f748984697cbdd6b02279:

  ARM: u300: bump all IRQ numbers by one (2012-04-20 09:52:58 +0200)

----------------------------------------------------------------
Linus Walleij (1):
      ARM: u300: bump all IRQ numbers by one

Mark Brown (1):
      ARM: ux300: Fix unimplementable regulation constraints

 arch/arm/mach-u300/core.c              |    6 +-
 arch/arm/mach-u300/i2c.c               |    9 +-
 arch/arm/mach-u300/include/mach/irqs.h |  150 ++++++++++++++++----------------
 3 files changed, 80 insertions(+), 85 deletions(-)
