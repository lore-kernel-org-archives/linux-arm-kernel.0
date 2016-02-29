From: rogerq@ti.com (Roger Quadros)
Date: Mon, 29 Feb 2016 20:07:44 +0200
Subject: [GIT PULL] omap gpmc enhancements for v4.6
Message-ID: <56D488F0.8070406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git at github.com:rogerq/linux.git tags/gpmc-omap-for-v4.6

for you to fetch changes up to e116c0545d17be6cc95a559aa5a68c221330501b:

  dt-bindings: bus: ti-gpmc: Add AAD timings properties (2016-02-08 16:22:03 +0200)

----------------------------------------------------------------
OMAP-GPMC: Add address/data muxed timings

* Add support for the GPMC Advanced AAD (address/data muxed) timings
on hardware supporting the feature like the AM335x and DM816X.

----------------------------------------------------------------
Neil Armstrong (2):
      memory: omap-gpmc: Add support for AAD timings
      dt-bindings: bus: ti-gpmc: Add AAD timings properties

 Documentation/devicetree/bindings/bus/ti-gpmc.txt |  5 +++++
 drivers/memory/omap-gpmc.c                        | 30 ++++++++++++++++++++++++++++++
 include/linux/omap-gpmc.h                         |  5 +++++
 3 files changed, 40 insertions(+)

--
cheers,
-roger
