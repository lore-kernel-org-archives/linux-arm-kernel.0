From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Nov 2012 15:06:55 +0100
Subject: [GIT PULL] MTU clock fixes
Message-ID: <CACRpkdYZSpttuzrU2zJrALUMOpfZdYuVsAVK+jEDah1GwavnRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

As agreed with Arnd here is a tag with the two patches to the clock
and clocksource
for the MTU timer that we were worried would clash with ARM SoC if they were
merged into the clk tree.

It is based on the suggested commit in the multiplatform branch.

Please pull it in!

Yours,
Linus Walleij


The following changes since commit c3b9d1db23c4ebd4d8a0964ebcf5f27d4eb8fa3f:

  ARM: plat-nomadik: convert platforms to SPARSE_IRQ (2012-11-05 09:55:34 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/mtu-clk-for-arm-soc

for you to fetch changes up to 16defa668d009a762e23d55ce6ecf5ae483dfe10:

  clocksource/mtu-nomadik: use apb_pclk (2012-11-16 14:44:02 +0100)

----------------------------------------------------------------
This tag contains two MTU patches based on top of the ux500 sparse IRQ
commit to avoid merge clashes.

----------------------------------------------------------------
Ulf Hansson (2):
      clk: ux500: Register mtu apb_pclocks
      clocksource/mtu-nomadik: use apb_pclk

 drivers/clk/ux500/u8500_clk.c     | 9 +++------
 drivers/clocksource/nomadik-mtu.c | 8 +++++++-
 2 files changed, 10 insertions(+), 7 deletions(-)
