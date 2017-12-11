From: rogerq@ti.com (Roger Quadros)
Date: Mon, 11 Dec 2017 16:16:27 +0200
Subject: [GIT PULL] omap-gpmc changes for v4.16 merge (immutable for mtd)
Message-ID: <b55511ad-6d23-0356-f2d3-8e2b7c6d1ffb@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://github.com/rogerq/linux.git tags/gpmc-omap-for-v4.16-immutable

for you to fetch changes up to c18a7ac3398d0cef29749f9568666db8321aa4c9:

  memory: omap-gpmc: Make 'bank-width' property optional (2017-12-01 15:37:49 +0200)

----------------------------------------------------------------
OMAP-GPMC: driver updates for v4.16
* Error out only if both 'bank-width' and 'gpmc,device-width' DT properties are missing.

----------------------------------------------------------------
Ladislav Michl (1):
      memory: omap-gpmc: Make 'bank-width' property optional

 drivers/memory/omap-gpmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
