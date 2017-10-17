From: rogerq@ti.com (Roger Quadros)
Date: Tue, 17 Oct 2017 15:26:00 +0300
Subject: [GIT PULL] omap-gpmc updates for v4.15
Message-ID: <b911ad22-7dad-a9d9-2814-a29937b9be0c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?Hi Olof/Arnd,

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://github.com/rogerq/linux.git tags/gpmc-omap-for-v4.15

for you to fetch changes up to 0d96a4f6a03797b73bee465cada39133b7972e8d:

  memory: omap-gpmc: Drop gpmc_status (2017-10-17 14:46:37 +0300)

----------------------------------------------------------------
OMAP-GPMC: driver updates for v4.15
* get rid of unused field in platform data structure.

----------------------------------------------------------------
Ladislav Michl (1):
      memory: omap-gpmc: Drop gpmc_status

 drivers/memory/omap-gpmc.c                   | 1 -
 include/linux/platform_data/mtd-nand-omap2.h | 2 --
 2 files changed, 3 deletions(-)

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
