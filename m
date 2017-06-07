From: tony@atomide.com (Tony Lindgren)
Date: Wed,  7 Jun 2017 05:25:24 -0700
Subject: [GIT PULL 1/2] omap gpmc changes for v4.13
Message-ID: <pull-1496838233-684770>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.13/gpmc-signed

for you to fetch changes up to c9eabf40d91b4fe954efe380d88590d933baa06d:

  memory: omap-gpmc: add error message if bank-width property is absent (2017-05-31 10:08:10 -0700)

----------------------------------------------------------------
Few improvments for GPMC (General Purpose Memory Controller)
found on TI SoCs to produce an error for missing bank-width
and to make the bootloader timing debug output usable for
device tree timings.

----------------------------------------------------------------
Uwe Kleine-K?nig (2):
      memory: omap-gpmc: make dts snippet include semicolon
      memory: omap-gpmc: add error message if bank-width property is absent

 drivers/memory/omap-gpmc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
