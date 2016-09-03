From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 02 Sep 2016 17:18:23 -0700
Subject: [GIT PULL] Amlogic driver updates for v4.9
Message-ID: <7hfuph25v4.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Below is a pull for Amlogic drivers for v4.9.  They all have acks from
the corresponding maintainers.

Kevin


The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-drivers

for you to fetch changes up to ad855eae6caf0d1dd17bce5bcd8e07759adc9903:

  nvmem: amlogic: Add Amlogic Meson EFUSE driver (2016-09-01 14:24:21 -0700)

----------------------------------------------------------------
Amlogic drivers for v4.9
- add secure monitor and eFuse driver
- add IR remote driver

----------------------------------------------------------------
Carlo Caione (2):
      firmware: Amlogic: Add secure monitor driver
      nvmem: amlogic: Add Amlogic Meson EFUSE driver

Neil Armstrong (1):
      media: rc: meson-ir: Add support for newer versions of the IR decoder

 drivers/firmware/Kconfig                |   1 +
 drivers/firmware/Makefile               |   1 +
 drivers/firmware/meson/Kconfig          |   9 ++++
 drivers/firmware/meson/Makefile         |   1 +
 drivers/firmware/meson/meson_sm.c       | 248 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/media/rc/meson-ir.c             |  29 ++++++++++---
 drivers/nvmem/Kconfig                   |  10 +++++
 drivers/nvmem/Makefile                  |   2 +
 drivers/nvmem/meson-efuse.c             |  93 +++++++++++++++++++++++++++++++++++++++++
 include/linux/firmware/meson/meson_sm.h |  31 ++++++++++++++
 10 files changed, 420 insertions(+), 5 deletions(-)
 create mode 100644 drivers/firmware/meson/Kconfig
 create mode 100644 drivers/firmware/meson/Makefile
 create mode 100644 drivers/firmware/meson/meson_sm.c
 create mode 100644 drivers/nvmem/meson-efuse.c
 create mode 100644 include/linux/firmware/meson/meson_sm.h
