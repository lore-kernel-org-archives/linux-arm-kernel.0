From: bcm@fixthebug.org (Christian Daudt)
Date: Sun, 5 Jan 2014 22:58:36 -0800
Subject: [GIT PULL] bcm driver updates for 3.14
Message-ID: <CAEPRUYpgHhrVCoRAzF_WbQZGTpwSahQq8G40+9=pf36-n9V_hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:

  Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)

are available in the git repository at:

  git://github.com/broadcom/bcm11351.git tags/bcm-for-3.14-drivers

for you to fetch changes up to e257c5f6e1cad35d15c06d713b2d1a26f883bbcb:

  clk: bcm281xx: define U32_MAX conditionally for now (2013-12-31
09:54:45 -0800)

----------------------------------------------------------------
Clk driver for bcm mobile SoCs

----------------------------------------------------------------
Alex Elder (2):
      clk: bcm281xx: add initial clock framework support
      clk: bcm281xx: define U32_MAX conditionally for now

Tim Kryger (1):
      clocksource: kona: Add basic use of external clock

 drivers/clk/Kconfig                  |    1 +
 drivers/clk/Makefile                 |    1 +
 drivers/clk/bcm/Kconfig              |    8 +
 drivers/clk/bcm/Makefile             |    3 +
 drivers/clk/bcm/clk-bcm281xx.c       |  416 ++++++++++++++
 drivers/clk/bcm/clk-kona-setup.c     |  769 +++++++++++++++++++++++++
 drivers/clk/bcm/clk-kona.c           | 1033 ++++++++++++++++++++++++++++++++++
 drivers/clk/bcm/clk-kona.h           |  416 ++++++++++++++
 drivers/clocksource/bcm_kona_timer.c |   14 +-
 include/dt-bindings/clock/bcm281xx.h |   65 +++
 10 files changed, 2723 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/bcm/Kconfig
 create mode 100644 drivers/clk/bcm/Makefile
 create mode 100644 drivers/clk/bcm/clk-bcm281xx.c
 create mode 100644 drivers/clk/bcm/clk-kona-setup.c
 create mode 100644 drivers/clk/bcm/clk-kona.c
 create mode 100644 drivers/clk/bcm/clk-kona.h
 create mode 100644 include/dt-bindings/clock/bcm281xx.h
