From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 23 Nov 2016 11:01:02 +0100
Subject: serial: Add LED trigger support
Message-ID: <20161123100106.15969-1-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series brings LED trigger support to the serial_core layer
and adopts some driver to use it.
This is an updated version of https://patchwork.kernel.org/patch/9212885/
which added LED trigger support to the i.MX serial driver only.

Sascha

----------------------------------------------------------------
Sascha Hauer (4):
      serial: core: Add LED trigger support
      serial: 8250: Add LED trigger support
      serial: cpm_uart: Add LED trigger support
      serial: imx: Add LED trigger support

 drivers/tty/serial/8250/8250_core.c         | 12 ++++-
 drivers/tty/serial/8250/8250_port.c         |  4 ++
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 22 ++++++++-
 drivers/tty/serial/imx.c                    | 24 +++++++++-
 drivers/tty/serial/serial_core.c            | 73 +++++++++++++++++++++++++++++
 include/linux/serial_core.h                 | 10 ++++
 6 files changed, 139 insertions(+), 6 deletions(-)
