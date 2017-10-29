From: khilman@baylibre.com (Kevin Hilman)
Date: Sun, 29 Oct 2017 09:44:09 -0700
Subject: [GIT PULL] Amlogic driver updates for v4.15, round 2
Message-ID: <7htvyhq4yu.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5e68c0fc8df8a588b15cd469b27b8b5dbfadc6c3:

  soc: amlogic: Add Meson6/Meson8/Meson8b/Meson8m2 SoC Information driver (2017-10-06 15:36:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-drivers-2

for you to fetch changes up to 8fca9e95243128961357577ba394ec1d4bd8c92c:

  dt-bindings: power: add amlogic meson power domain bindings (2017-10-29 08:15:09 -0700)

----------------------------------------------------------------
Amlogic drivers for v4.15, round 2
- add PM domain driver for GX VPU

----------------------------------------------------------------
Neil Armstrong (2):
      soc: amlogic: add Meson GX VPU Domains driver
      dt-bindings: power: add amlogic meson power domain bindings

 Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt |  61 ++++++++++++++++++++++
 drivers/soc/amlogic/Kconfig                                       |  10 ++++
 drivers/soc/amlogic/Makefile                                      |   1 +
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c                           | 234 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 306 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
 create mode 100644 drivers/soc/amlogic/meson-gx-pwrc-vpu.c
