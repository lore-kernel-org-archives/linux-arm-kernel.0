From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Sun, 23 Dec 2012 21:02:05 -0300
Subject: [PATCH 0/3] OMAP GPMC OneNAND DT bindings
Message-ID: <CALF0-+VOjr6O=+EPFsav1jghfsp624H9w48+JP8_JQgFoAAt=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Just in case anyone wants to access his OneNAND device,
here's a little patchset. Feedback is more than welcome.

It's based on arm-soc/for-next with Daniel Mack's GPMC patches.

Ezequiel Garcia (3):
  mtd: omap-onenand: pass device_node in platform data
  arm: omap2: gpmc-onenand: drop __init annotation
  arm: omap2: gpmc: add DT bindings for OneNAND

 .../devicetree/bindings/mtd/gpmc-onenand.txt       |   44 ++++++++++++++++++++
 arch/arm/mach-omap2/gpmc-onenand.c                 |    2 +-
 arch/arm/mach-omap2/gpmc.c                         |   44 ++++++++++++++++++++
 drivers/mtd/onenand/omap2.c                        |    4 +-
 include/linux/platform_data/mtd-onenand-omap2.h    |    3 +
 5 files changed, 95 insertions(+), 2 deletions(-)

Regards,

-- 
    Ezequiel
