From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 16 Aug 2017 21:15:27 -0700
Subject: [GIT PULL] Amlogic driver updates for v4.14
Message-ID: <7hinhmakyo.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-drivers

for you to fetch changes up to a9daaba2965e8b132424514e184fc40ee6f9e00c:

  soc: Add Amlogic SoC Information driver (2017-07-28 09:25:07 -0700)

----------------------------------------------------------------
Amlogic driver updates for v4.14
- add SoC info driver

----------------------------------------------------------------
Neil Armstrong (2):
      dt-bindings: arm: amlogic: Add SoC information bindings
      soc: Add Amlogic SoC Information driver

 Documentation/devicetree/bindings/arm/amlogic.txt |  29 +++++++++++++++
 drivers/soc/Kconfig                               |   1 +
 drivers/soc/Makefile                              |   1 +
 drivers/soc/amlogic/Kconfig                       |  12 +++++++
 drivers/soc/amlogic/Makefile                      |   1 +
 drivers/soc/amlogic/meson-gx-socinfo.c            | 177 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 221 insertions(+)
 create mode 100644 drivers/soc/amlogic/Kconfig
 create mode 100644 drivers/soc/amlogic/Makefile
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo.c
