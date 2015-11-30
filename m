From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 30 Nov 2015 18:53:32 +0900
Subject: [PATCH 0/4] i2c: uniphier: add minor sanity checks to
 i2c-uniphier/i2c-uniphier-f
Message-ID: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




Masahiro Yamada (4):
  i2c: uniphier: error out if clock rate is zero
  i2c: uniphier: error out if bus speed is zero
  i2c: uniphier_f: error out if clock rate is zero
  i2c: uniphier_f: error out if bus speed is zero

 drivers/i2c/busses/i2c-uniphier-f.c | 11 ++++++++++-
 drivers/i2c/busses/i2c-uniphier.c   | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
1.9.1
