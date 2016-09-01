From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  1 Sep 2016 20:46:27 +0900
Subject: [PATCH 0/3] i2c: uniphier: updates for v4.9
Message-ID: <1472730390-8907-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




Masahiro Yamada (3):
  i2c: uniphier: avoid WARN_ON() of clk_disable() in failure path
  i2c: uniphier-f: avoid WARN_ON() of clk_disable() in failure path
  i2c: uniphier-f: set the adapter to master mode when probing

 drivers/i2c/busses/i2c-uniphier-f.c | 85 +++++++++++++++++--------------------
 drivers/i2c/busses/i2c-uniphier.c   | 73 ++++++++++++++-----------------
 2 files changed, 71 insertions(+), 87 deletions(-)

-- 
1.9.1
