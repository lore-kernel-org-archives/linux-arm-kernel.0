From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Jan 2013 00:40:07 +0100
Subject: [GIT PULL] nomadik fixes for v3.8
Message-ID: <CACRpkdb4yM_j9U05z0+bg1XBoqEsGY0xS-znkEUd15UfTP79Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

could you please pull these two fixes into ARM SoC for the v3.8-rc
series, so Nomadik compiles and boots again...

Thanks!

Linus Walleij


The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/nomadik-fixes-for-arm-soc

for you to fetch changes up to d9621176872319a568d9892701410bcbfbd5b35c:

  ARM: nomadik: bump the IRQ numbers again (2013-01-03 23:42:07 +0100)

----------------------------------------------------------------
Two fixes to the Nomadik:
- Delete a dangling include
- Bump IRQ numbers to offset at 32

----------------------------------------------------------------
Linus Walleij (2):
      ARM: nomadik: delete dangling include
      ARM: nomadik: bump the IRQ numbers again

 arch/arm/mach-nomadik/board-nhk8815.c     |  1 -
 arch/arm/mach-nomadik/include/mach/irqs.h | 78 +++++++++++++++----------------
 2 files changed, 39 insertions(+), 40 deletions(-)
