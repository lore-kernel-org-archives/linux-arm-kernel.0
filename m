From: rogerq@ti.com (Roger Quadros)
Date: Fri, 3 Nov 2017 15:24:28 +0200
Subject: [GIT PULL] omap-gpmc updates for v4.15, part 2
Message-ID: <80844929-ce3d-5c4a-91e4-e589f693ecd7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://github.com/rogerq/linux.git tags/gpmc-omap-for-v4.15-pt2

for you to fetch changes up to a622c641665c32a879348efb2abc389527479ee4:

  memory: omap-gpmc: Remove deprecated gpmc_update_nand_reg() (2017-11-03 15:06:11 +0200)

----------------------------------------------------------------
OMAP-GPMC: driver updates for v4.15, part 2
* get rid of unused function gpmc_update_nand_reg().

----------------------------------------------------------------
Ladislav Michl (2):
      memory: omap-gpmc: Drop gpmc_status
      memory: omap-gpmc: Remove deprecated gpmc_update_nand_reg()

 drivers/memory/omap-gpmc.c                   | 54 +++++++++++++---------------
 include/linux/omap-gpmc.h                    | 12 -------
 include/linux/platform_data/mtd-nand-omap2.h |  2 --
 3 files changed, 24 insertions(+), 44 deletions(-)

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
