From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 29 Jul 2013 14:16:11 +0200
Subject: [GIT PULL] Reset controller changes for 3.12
Message-ID: <1375100171.4223.10.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

with the cosmetic issues pointed out by Ben and Sylwester fixed in the
gpio-reset driver, the following changes since commit
5ae90d8e467e625e447000cb4335c4db973b1095:

  Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git reset/for_v3.12

for you to fetch changes up to f4d36f8a5166405154c638c1e49e253f2f017dd7:

  reset: allow drivers to request probe deferral (2013-07-29 14:03:40
+0200)

----------------------------------------------------------------
Philipp Zabel (2):
      reset: Add driver for gpio-controlled reset pins
      reset: allow drivers to request probe deferral

 .../devicetree/bindings/reset/gpio-reset.txt       |  35 +++++
 drivers/reset/Kconfig                              |  11 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/core.c                               |   2 +-
 drivers/reset/gpio-reset.c                         | 174
+++++++++++++++++++++
 5 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644
Documentation/devicetree/bindings/reset/gpio-reset.txt
 create mode 100644 drivers/reset/gpio-reset.c
