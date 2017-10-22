From: khilman@baylibre.com (Kevin Hilman)
Date: Sun, 22 Oct 2017 03:36:34 -0700
Subject: [GIT PULL] Amlogic driver updates for v4.15
Message-ID: <7hr2tvqxjh.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-drivers

for you to fetch changes up to 5e68c0fc8df8a588b15cd469b27b8b5dbfadc6c3:

  soc: amlogic: Add Meson6/Meson8/Meson8b/Meson8m2 SoC Information driver (2017-10-06 15:36:17 -0700)

----------------------------------------------------------------
Amlogic drivers for v4.15
- add SoC info driver for 32-bit Amlogic SoCs

----------------------------------------------------------------
Martin Blumenstingl (1):
      soc: amlogic: Add Meson6/Meson8/Meson8b/Meson8m2 SoC Information driver

 drivers/soc/amlogic/Kconfig            |  10 +++++++
 drivers/soc/amlogic/Makefile           |   1 +
 drivers/soc/amlogic/meson-mx-socinfo.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/soc/amlogic/meson-mx-socinfo.c
