From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 May 2011 17:51:25 +0800
Subject: [PATCH 0/4] add gpio driver gpio-mxs
Message-ID: <1305885089-27343-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set is to move Freescale MXS gpio driver from mach-mxs
into drivers/gpio.  Different from u300 gpio driver that all gpio
ports are registered as one device, gpio-mxs expects every single
port is a gpio device.

The first 3 patches are just to ease review and can be squashed into
the last one.

Shawn Guo (4):
      gpio: gpio-mxs: add file gpio-mxs.c
      gpio: gpio-mxs: drop mach-specific accessors
      gpio: gpio-mxs: remove gpio port definition and registration
      gpio: gpio-mxs: add gpio driver for Freescale MXS architecture

 drivers/gpio/Kconfig    |    3 +
 drivers/gpio/Makefile   |    1 +
 drivers/gpio/gpio-mxs.c |  371 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 375 insertions(+), 0 deletions(-)

Regards,
Shawn
