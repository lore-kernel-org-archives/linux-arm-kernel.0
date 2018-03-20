From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 19 Mar 2018 17:05:12 -0700
Subject: [GIT PULL] Amlogic driver updates for v4.17
Message-ID: <7hpo3zr4qv.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-drivers

for you to fetch changes up to f842c41adc044e4586dd232c6e889f9d46180fa8:

  amlogic: meson-gx-socinfo: Update soc ids (2018-03-19 16:40:26 -0700)

----------------------------------------------------------------
Amlogic driver updates for v4.17
- socinfo: add more IDs for newer SoC detection
- firmware: update init to use module_platform_driver_probe
- soc: mix. VPU power controller fixes

----------------------------------------------------------------
Heiner Kallweit (2):
      soc: amlogic: meson-gx-pwrc-vpu: don't print error message on probe deferral
      soc: amlogic: meson-gx-pwrc-vpu: fix error on shutdown when domain is powered off

Neil Armstrong (1):
      amlogic: meson-gx-socinfo: Update soc ids

Sudeep Holla (1):
      firmware: meson-sm: rework meson_sm_init to use module_platform_driver_probe

weiyongjun (A) (2):
      meson-mx-socinfo: Make local function meson_mx_socinfo_init() static
      meson-gx-socinfo: make local function meson_gx_socinfo_init static

 drivers/firmware/meson/meson_sm.c       | 25 ++++++++++++-------------
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c |  9 +++++++--
 drivers/soc/amlogic/meson-gx-socinfo.c  | 12 +++++++++++-
 drivers/soc/amlogic/meson-mx-socinfo.c  |  2 +-
 4 files changed, 31 insertions(+), 17 deletions(-)
