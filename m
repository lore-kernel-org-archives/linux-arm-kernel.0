From: rogerq@ti.com (Roger Quadros)
Date: Fri, 11 May 2018 07:28:51 +0300
Subject: [GIT PULL] omap-gpmc updates for v4.18
Message-ID: <75040f4e-9499-55a4-fad6-f27cab0bb224@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof/Arnd,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://github.com/rogerq/linux.git tags/gpmc-omap-for-v4.18

for you to fetch changes up to d507178f2ebb7bde5b3f64557f1c8f80e7b82541:

  memory: omap-gpmc: Avoid redundant NULL check (2018-04-24 10:30:52 +0300)

----------------------------------------------------------------
OMAP-GPMC: driver updates for v4.18
* get rid of a redundant NULL check in gpmc_probe_dt_children()

----------------------------------------------------------------
Roger Quadros (1):
      memory: omap-gpmc: Avoid redundant NULL check

 drivers/memory/omap-gpmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
