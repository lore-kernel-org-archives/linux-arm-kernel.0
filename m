From: rogerq@ti.com (Roger Quadros)
Date: Fri, 12 Aug 2016 14:02:47 +0300
Subject: [GIT PULL] omap-gpmc fixes for v4.8-rc1
Message-ID: <a2bf20d0-c446-2fab-5de2-33636eab79a7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://github.com/rogerq/linux.git tags/gpmc-omap-v4.8-rc1

for you to fetch changes up to 23540d6e2f3193b946c4de43e3f9654fa6d23fe7:

  memory: omap-gpmc: allow probe of child nodes to fail (2016-08-08 11:18:40 +0300)

----------------------------------------------------------------
OMAP-GPMC: fixes for v4.8-rc1

* Allow other children of GPMC to probe even if any child fails.
This fixes problem on Overo boards where networking device child
doesn't probe due to broken NAND child.

----------------------------------------------------------------
Johan Hovold (1):
      memory: omap-gpmc: allow probe of child nodes to fail

 drivers/memory/omap-gpmc.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)
