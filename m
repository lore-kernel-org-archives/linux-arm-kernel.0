From: rogerq@ti.com (Roger Quadros)
Date: Thu, 16 Jun 2016 12:14:26 +0300
Subject: [GIT PULL] omap-gpmc fixes for v4.7 rc cycle
Message-ID: <57626DF2.70907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

The following changes since commit 5edb56491d4812c42175980759da53388e5d86f5:

  Linux 4.7-rc3 (2016-06-12 07:20:35 -0700)

are available in the git repository at:

  https://github.com/rogerq/linux.git tags/gpmc-omap-fixes-for-v4.7

for you to fetch changes up to 8f50b8e57442d28e41bb736c173d8a2490549a82:

  memory: omap-gpmc: Fix omap gpmc EXTRADELAY timing (2016-06-16 11:43:48 +0300)

----------------------------------------------------------------
OMAP-GPMC: Fixes for for v4.7-rc cycle:

- Fix omap gpmc EXTRADELAY timing. The DT provided timings
were wrongly used causing devices requiring extra delay timing
to fail.

----------------------------------------------------------------
Ocquidant, Sebastien (1):
      memory: omap-gpmc: Fix omap gpmc EXTRADELAY timing

 drivers/memory/omap-gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
