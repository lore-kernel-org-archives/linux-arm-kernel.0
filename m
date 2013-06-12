From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Jun 2013 11:24:35 -0700
Subject: [GIT PULL 4/6] omap gpmc changes for v3.11 merge window
In-Reply-To: <pull-1371061475-206272>
Message-ID: <mailman.1.1371061527.1060.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/gpmc-signed

for you to fetch changes up to b3f5525c55ce5cb67af06f04dbbf28358da23a2c:

  ARM: OMAP2+: gpmc: Converts GPMC driver to pm_runtime capable (2013-06-12 09:56:30 -0700)

----------------------------------------------------------------
Omap GPMC (General Purpose Memory Controller) changes.

----------------------------------------------------------------
Christoph Fritz (1):
      ARM: OMAP2+: nand: reorganize gpmc timing values

Gupta Pekon (1):
      ARM: OMAP2+: gpmc: get number of useable GPMC chip-selects via DT

Jon Hunter (1):
      ARM: dts: OMAP2+: Simplify NAND support

Mark Jackson (1):
      ARM: OMAP2+: Allow NAND transfer mode to be specified in DT

avinash philip (1):
      ARM: OMAP2+: gpmc: Converts GPMC driver to pm_runtime capable

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  1 -
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  8 +++
 arch/arm/boot/dts/omap3430-sdp.dts                 |  1 -
 arch/arm/mach-omap2/board-flash.c                  |  3 ++
 arch/arm/mach-omap2/gpmc-nand.c                    | 44 ++--------------
 arch/arm/mach-omap2/gpmc.c                         | 61 +++++++++++++++++-----
 6 files changed, 63 insertions(+), 55 deletions(-)
