From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Nov 2015 20:45:21 +0900
Subject: [PATCH 0/3] pinctrl: use CONFIG_PINCTRL_* to gurad subdirectories
Message-ID: <1448365524-12605-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Masahiro Yamada (3):
  pinctrl: berlin: guard sub-directory with CONFIG_PINCTRL_BERLIN
  pinctrl: mvebu: guard sub-directory with CONFIG_PINCTRL_MVEBU
  pinctrl: spear: guard sub-directory with CONFIG_PINCTRL_SPEAR

 drivers/pinctrl/Makefile        | 6 +++---
 drivers/pinctrl/berlin/Makefile | 2 +-
 drivers/pinctrl/mvebu/Makefile  | 2 +-
 drivers/pinctrl/spear/Makefile  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.9.1
