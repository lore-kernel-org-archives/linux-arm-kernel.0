From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 14 May 2018 17:54:34 +0200
Subject: [GIT PULL] Reset controller fixes for v4.17
Message-ID: <1526313274.4936.21.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.pengutronix.de/pza/linux.git tags/reset-fixes-for-4.17

for you to fetch changes up to e6914365fd280fce303a89b8a8d4529af5a2e0f9:

  reset: uniphier: fix USB clock line for LD20 (2018-04-27 11:51:12 +0200)

----------------------------------------------------------------
Reset controller fixes for v4.17

Fix the USB3 reset (offset 0x200c, bit 5) on Uniphier LD20. It was
incorrectly labeled as GIO reset. This reset line is not yet used in
uniphier-ld20.dtsi.

----------------------------------------------------------------
Masahiro Yamada (1):
      reset: uniphier: fix USB clock line for LD20

 drivers/reset/reset-uniphier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
