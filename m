From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jul 2014 12:41:23 +0200
Subject: [GIT PULL] Ux500 core changes for v3.17 take 1
Message-ID: <CACRpkdY4FHgiJXZFyfdxSJAb3R03Kwk6oqVK5UvzX=AdQVnaAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

these are some minor Ux500 cleanups that have been pending
a while. Please pull this in for v3.17.

Yours,
Linus Walleij

The following changes since commit cd3de83f147601356395b57a8673e9c5ff1e59d1:

  Linux 3.16-rc4 (2014-07-06 12:37:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-core-for-v3.17-1

for you to fetch changes up to 823e7546c4a2bd4c8edce6d8dc8544fd79287c55:

  ARM: ux500: remove pointless cache setup complexity (2014-07-10
10:46:42 +0200)

----------------------------------------------------------------
Some minor cleanups to the Ux500 core. DT-only probe path and
some constification from static code analysis.

----------------------------------------------------------------
Linus Walleij (1):
      ARM: ux500: remove pointless cache setup complexity

Sachin Kamat (2):
      ARM: ux500: Staticize local symbols in cpu-db8500.c
      ARM: ux500: Staticize ab8505_regulators

Thierry Reding (1):
      ARM: ux500: Staticise ux500_soc_attr

Tobias Klauser (1):
      ARM: ux500: storage class should be before const qualifier

 arch/arm/mach-ux500/board-mop500-regulators.c |  2 +-
 arch/arm/mach-ux500/cache-l2x0.c              | 18 ++++--------------
 arch/arm/mach-ux500/cpu-db8500.c              |  8 ++++----
 arch/arm/mach-ux500/cpu.c                     |  2 +-
 arch/arm/mach-ux500/timer.c                   |  2 +-
 5 files changed, 11 insertions(+), 21 deletions(-)
