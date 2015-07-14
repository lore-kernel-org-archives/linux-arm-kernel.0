From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 14 Jul 2015 11:40:00 +0900
Subject: [PATCH v2 0/7] This series adds pinctrl drivers for UniPhier SoC
 family.
Message-ID: <1436841607-7556-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1/7: core support code commonly used for all the pinctrl drivers.
2/7-7/7: driver for each SoC



Masahiro Yamada (7):
  pinctrl: UniPhier: add UniPhier pinctrl core support
  pinctrl: UniPhier: add UniPhier PH1-LD4 pinctrl driver
  pinctrl: UniPhier: add UniPhier PH1-Pro4 pinctrl driver
  pinctrl: UniPhier: add UniPhier PH1-sLD8 pinctrl driver
  pinctrl: UniPhier: add UniPhier PH1-Pro5 pinctrl driver
  pinctrl: UniPhier: add UniPhier ProXstream2 pinctrl driver
  pinctrl: UniPhier: add UniPhier PH1-LD6b pinctrl driver

 drivers/pinctrl/Kconfig                          |    1 +
 drivers/pinctrl/Makefile                         |    1 +
 drivers/pinctrl/uniphier/Kconfig                 |   32 +
 drivers/pinctrl/uniphier/Makefile                |    8 +
 drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c       |  886 ++++++++++++
 drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c      | 1274 ++++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c      | 1554 ++++++++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c      | 1346 +++++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c      |  794 +++++++++++
 drivers/pinctrl/uniphier/pinctrl-proxstream2.c   | 1269 ++++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c |  684 ++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier.h      |  217 +++
 12 files changed, 8066 insertions(+)
 create mode 100644 drivers/pinctrl/uniphier/Kconfig
 create mode 100644 drivers/pinctrl/uniphier/Makefile
 create mode 100644 drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c
 create mode 100644 drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c
 create mode 100644 drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c
 create mode 100644 drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c
 create mode 100644 drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c
 create mode 100644 drivers/pinctrl/uniphier/pinctrl-proxstream2.c
 create mode 100644 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
 create mode 100644 drivers/pinctrl/uniphier/pinctrl-uniphier.h

-- 
1.9.1
