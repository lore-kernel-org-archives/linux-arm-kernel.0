From: rogerq@ti.com (Roger Quadros)
Date: Mon, 29 Aug 2016 11:30:34 +0300
Subject: [GIT PULL] omap-gpmc changes for v4.9 merge window
Message-ID: <16b618d9-735f-f20c-7966-6e3d23b6b44e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof/Arnd,

The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:

  Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)

are available in the git repository at:

  https://github.com/rogerq/linux.git tags/gpmc-omap-for-v4.9

for you to fetch changes up to 3950fffdf0c088dd4d9e85c9a5a6be4c6e8b5a07:

  memory: omap-gpmc: make gpmc_clk_ticks_to_ns() static (2016-08-29 11:00:24 +0300)

----------------------------------------------------------------
OMAP-GPMC: driver updates for v4.9

* Fix potential build failure if CONFIG_OMAP_GPMC is disabled while
  OMAP_NAND driver is enabled
* Trivial fixes which fix build warnings and code check tool warnings
  (Coccinelle)
* Use devm_gpiochip_add_data()

----------------------------------------------------------------
Baoyou Xie (1):
      memory: omap-gpmc: make gpmc_clk_ticks_to_ns() static

Linus Walleij (1):
      memory: omap-gpmc: use devm_gpiochip_add_data()

Markus Elfring (1):
      memory: omap-gpmc: Delete an unnecessary check before the function call "gpiochip_free_own_desc"

Roger Quadros (1):
      memory: omap-gpmc: Fix build with CONFIG_OMAP_GPMC disabled

 drivers/memory/omap-gpmc.c | 20 +++++---------------
 include/linux/omap-gpmc.h  |  4 ++--
 2 files changed, 7 insertions(+), 17 deletions(-)

--
cheers,
-roger
