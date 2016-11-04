From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 4 Nov 2016 11:26:30 +0100
Subject: [GIT PULL] ARM: OXNAS SoC DT updates for 4.10
Message-ID: <85ecb958-a6cb-bdd2-10db-873e1b894ad7@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://github.com/OXNAS/linux.git tags/oxnas-arm-soc-dt-for-4.10

for you to fetch changes up to 52c468fb37b663e0826f2bbdea61095bdd4e4b54:

  MAINTAINERS: oxnas: Add new files definitions (2016-11-04 11:23:21 +0100)

----------------------------------------------------------------
- Add DTSI for Oxford Semiconductor OX820
- Add DTS for Cloud Engines PogoPlug v3 board
- Fix MAINTAINERS Oxnas entry for dts files
from http://lkml.kernel.org/r/20161102141850.25164-1-narmstrong at baylibre.com

----------------------------------------------------------------
Neil Armstrong (2):
      ARM: dts: Add support for OX820 and Pogoplug V3
      MAINTAINERS: oxnas: Add new files definitions

 Documentation/devicetree/bindings/arm/oxnas.txt      |   5 ++
 MAINTAINERS                                          |   3 +-
 arch/arm/boot/dts/Makefile                           |   3 +-
 arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts |  94 +++++++++++++++++++++++
 arch/arm/boot/dts/ox820.dtsi                         | 296 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 399 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
 create mode 100644 arch/arm/boot/dts/ox820.dtsi

Thanks,
Neil
