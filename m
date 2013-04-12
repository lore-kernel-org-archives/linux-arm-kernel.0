From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 12 Apr 2013 10:42:11 +0200
Subject: [GIT PULL v3] Reset controller API
Message-ID: <1365756131.5330.10.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

the following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:

  Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git reset/for_v3.10

for you to fetch changes up to 6034bb22d8387708075c083385e5d2e1072a4f33:

  reset: NULL deref on allocation failure (2013-04-12 10:26:24 +0200)

----------------------------------------------------------------
Dan Carpenter (1):
      reset: NULL deref on allocation failure

Philipp Zabel (1):
      reset: Add reset controller API

Stephen Warren (1):
      dt: describe base reset signal binding

 Documentation/devicetree/bindings/reset/reset.txt |  75 ++++++
 drivers/Kconfig                                   |   2 +
 drivers/Makefile                                  |   3 +
 drivers/reset/Kconfig                             |  13 +
 drivers/reset/Makefile                            |   1 +
 drivers/reset/core.c                              | 297 ++++++++++++++++++++++
 include/linux/reset-controller.h                  |  51 ++++
 include/linux/reset.h                             |  17 ++
 8 files changed, 459 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/reset.txt
 create mode 100644 drivers/reset/Kconfig
 create mode 100644 drivers/reset/Makefile
 create mode 100644 drivers/reset/core.c
 create mode 100644 include/linux/reset-controller.h
 create mode 100644 include/linux/reset.h
