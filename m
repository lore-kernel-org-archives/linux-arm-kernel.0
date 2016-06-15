From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 15 Jun 2016 17:18:04 +0900
Subject: [PATCH 0/2] pinctrl: uniphier: two more fixes for UniPhier pin data
Message-ID: <1465978686-28578-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Masahiro Yamada (2):
  pinctrl: uniphier: prohibit drive control for pin 61-66 of PH1-LD11
  pinctrl: uniphier: fix meaningless drive control offsets

 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 12 ++++++------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
1.9.1
