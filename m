From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Jan 2017 14:06:14 +0100
Subject: [GIT PULL] Ux500 development for v4.11
Message-ID: <CACRpkdZnk-qpJi-FOPuMyWBT-=AEK7krxZJZp=UZYzjbuBOK7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a set of two patches ready to be queued for v4.11 already.

Please pull them to a suitable branch on the ARM SoC tree.

Yours,
Linus Walleij

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dev-for-armsoc

for you to fetch changes up to f3c05596344fa09074220513583bc5d6ff2d5c43:

  ARM: ux500: remove duplicated include from cpu-db8500.c (2017-01-12
14:02:34 +0100)

----------------------------------------------------------------
Some two collected patches simplifying some Ux500
stuff.

----------------------------------------------------------------
Linus Walleij (1):
      ARM: ux500: simplify secondary boot

Wei Yongjun (1):
      ARM: ux500: remove duplicated include from cpu-db8500.c

 arch/arm/mach-ux500/cpu-db8500.c |  1 -
 arch/arm/mach-ux500/platsmp.c    | 45 +++++++++++++++++-----------------------
 2 files changed, 19 insertions(+), 27 deletions(-)
