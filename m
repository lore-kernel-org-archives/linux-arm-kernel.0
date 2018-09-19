From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 19 Sep 2018 14:28:10 +0900
Subject: [PATCH 0/3] serial: 8250_uniphier: remove unused code and add
 auto-flow-control
Message-ID: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 - Remove never-used DT property
 - Refactor code
 - Add auto-flow-control support



Dai Okamura (1):
  serial: 8250_uniphier: add auto-flow-control support

Masahiro Yamada (2):
  serial: 8250_uniphier: remove unused "fifo-size" property
  serial: 8250_uniphier: flatten probe function

 .../devicetree/bindings/serial/uniphier-uart.txt   |  3 +-
 drivers/tty/serial/8250/8250_uniphier.c            | 62 ++++++++--------------
 2 files changed, 22 insertions(+), 43 deletions(-)

-- 
2.7.4
