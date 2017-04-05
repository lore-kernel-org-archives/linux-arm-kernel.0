From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 05 Apr 2017 12:24:04 +0200
Subject: [GIT PULL] Reset controller changes for v4.12, part 2
Message-ID: <1491387844.2381.77.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

please consider merging this tag for v4.12, which just adds a few reset
lines for the NAND and eMMC controllers on Uniphier LD11/LD20 SoCs.

regards
Philipp

The following changes since commit 11282a49b735ad7f4cea187de2b8dc5489343e4b:

  reset: sunxi: fix for 64-bit compilation (2017-03-15 12:19:12 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.12-2

for you to fetch changes up to 23ade398c7c2809d031fe1d83ada11b3c08d73b4:

  reset: uniphier: add NAND and eMMC reset control (2017-03-28 18:45:35 +0200)

----------------------------------------------------------------
Reset controller changes for v4.12, part 2

Add reset lines for the NAND and eMMC contollers on LD11/LD20 SoCs.

----------------------------------------------------------------
Masahiro Yamada (1):
      reset: uniphier: add NAND and eMMC reset control

 drivers/reset/reset-uniphier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
