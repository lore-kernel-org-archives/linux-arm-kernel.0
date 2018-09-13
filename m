From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 13 Sep 2018 11:08:56 -0700
Subject: [GIT PULL] Amlogic driver updates for v4.20
Message-ID: <7hpnxhuv5z.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-drivers

for you to fetch changes up to d4983983d98710e4927fdb8de8e987c303b3fba3:

  soc: amlogic: add meson-canvas driver (2018-09-12 21:38:45 -0700)

----------------------------------------------------------------
Amlogic ARM64 driver updates for v4.20
- add meson-canvas driver and bindings
- firmware: Add serial number sysfs entry

----------------------------------------------------------------
Maxime Jourdan (2):
      dt-bindings: soc: amlogic: add meson-canvas documentation
      soc: amlogic: add meson-canvas driver

Neil Armstrong (1):
      firmware: meson_sm: Add serial number sysfs entry

 Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt |  29 +++++++++
 drivers/firmware/meson/meson_sm.c                                |  56 ++++++++++++++++++
 drivers/soc/amlogic/Kconfig                                      |   7 +++
 drivers/soc/amlogic/Makefile                                     |   1 +
 drivers/soc/amlogic/meson-canvas.c                               | 185 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/firmware/meson/meson_sm.h                          |   1 +
 include/linux/soc/amlogic/meson-canvas.h                         |  65 +++++++++++++++++++++
 7 files changed, 344 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt
 create mode 100644 drivers/soc/amlogic/meson-canvas.c
 create mode 100644 include/linux/soc/amlogic/meson-canvas.h
