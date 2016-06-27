From: rogerq@ti.com (Roger Quadros)
Date: Mon, 27 Jun 2016 11:34:35 +0300
Subject: [GIT PULL] omap-gpmc changes for v4.8 merge window
Message-ID: <5770E51B.8040206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  https://github.com/rogerq/linux.git gpmc-omap-for-v4.8

for you to fetch changes up to 32dd625a9f3541ee6d390f12f810f28531d016c7:

  memory: omap-gpmc: Move gpio functions out of #ifdef CONFIG_OF (2016-06-17 10:26:48 +0300)

----------------------------------------------------------------
OMAP-GPMC: driver updates for v4.8

* Make GPMC driver non modular as it is going to
be built-in only till arch/arm/mach-omap2 users
are removed.

* Fix build if CONFIG_OF is not defined.

----------------------------------------------------------------
Paul Gortmaker (1):
      memory: omap-gpmc: make it explicitly non-modular

Roger Quadros (1):
      memory: omap-gpmc: Move gpio functions out of #ifdef CONFIG_OF

 drivers/memory/omap-gpmc.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------
 1 file changed, 63 insertions(+), 73 deletions(-)
