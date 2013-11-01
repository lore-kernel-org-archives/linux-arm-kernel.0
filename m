From: jsarha@ti.com (Jyri Sarha)
Date: Fri, 1 Nov 2013 16:01:19 +0200
Subject: [PATCH RFC] gpio controlled clock
Message-ID: <cover.1383312867.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch implements a basic clock that can be enabled and disabled
trough a gpio output. There is such a clock at least on
Beaglebone-Black and I need such a clock to implement HDMI audio
support for the board. I just thought this simple driver could be
useful for wider audience.

Best regards,
Jyri

Jyri Sarha (1):
  clk: add gpio controlled clock

 .../devicetree/bindings/clock/gpio-clock.txt       |   21 +++
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-gpio.c                             |  154 ++++++++++++++++++++
 include/linux/clk-provider.h                       |   25 ++++
 4 files changed, 201 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/gpio-clock.txt
 create mode 100644 drivers/clk/clk-gpio.c

-- 
1.7.9.5
