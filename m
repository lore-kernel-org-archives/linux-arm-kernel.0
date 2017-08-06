From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  6 Aug 2017 11:44:00 +0900
Subject: [PATCH 0/2] reset: uniphier: UniPhier reset data update for v4.14
Message-ID: <1501987442-2583-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

Here are UniPhier SoCs updates for v4.14.

 - Remove old SoC support
 - Remove useless macros



Masahiro Yamada (2):
  reset: uniphier: remove sLD3 SoC support
  reset: uniphier: do not use per-SoC macro for system reset block

 .../devicetree/bindings/reset/uniphier-reset.txt   |  2 -
 drivers/reset/reset-uniphier.c                     | 96 +++++++---------------
 2 files changed, 31 insertions(+), 67 deletions(-)

-- 
2.7.4
