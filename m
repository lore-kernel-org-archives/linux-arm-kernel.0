From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 28 Sep 2018 11:05:06 +0900
Subject: [PATCH v2 0/3] serial: 8250_uniphier: remove unused code and add
 auto-flow-control
Message-ID: <1538100309-24323-1-git-send-email-yamada.masahiro@socionext.com>
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
