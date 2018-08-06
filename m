From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 06 Aug 2018 12:37:20 +0200
Subject: Reset controller changes for v4.19, part 2
Message-ID: <1533551840.4204.11.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

The following changes since commit 6b39fd590aebca1a6a4c827f29f14d2b6df3939d:

  reset: uniphier: add reset control support for SPI (2018-07-19 11:19:47 +0200)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.19-2

for you to fetch changes up to d903779b58be442f3afd2c51c46c7cf19c97684e:

  reset: meson: add meson audio arb driver (2018-07-20 18:17:31 +0200)

----------------------------------------------------------------
Reset controller changes for v4.19, part 2

This adds a single new driver for the Amlogic Meson Audio Memory Arbiter
resets.

----------------------------------------------------------------
Jerome Brunet (2):
      reset: meson: add dt-bindings for meson-axg audio arb
      reset: meson: add meson audio arb driver

 .../bindings/reset/amlogic,meson-axg-audio-arb.txt |  21 +++
 drivers/reset/Kconfig                              |   7 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-meson-audio-arb.c              | 168 +++++++++++++++++++++
 .../reset/amlogic,meson-axg-audio-arb.h            |  17 +++
 5 files changed, 214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
 create mode 100644 drivers/reset/reset-meson-audio-arb.c
 create mode 100644 include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
