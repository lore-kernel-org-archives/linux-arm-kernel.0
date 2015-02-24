From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 24 Feb 2015 11:17:04 +0100
Subject: [PATCH v2 0/7] serial: imx: a fix, cleanups and rs485 support
Message-ID: <1424773031-19692-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this is a rebased series for the imx serial driver. I already sent it
out a week ago basing on 3.19, but it doesn't apply to 4.0-rc1, so I did
the non-trivial rebasing and resend now.

I also reordered the patches to have the fix first. IMHO this can go in
before 4.0, the other 6 patches are merge window material.

Best regards
Uwe

Uwe Kleine-K?nig (7):
  serial: imx: Fix clearing of receiver overrun flag
  serial: imx: remove long dead code
  serial: imx: drop members from driver data that are only used during
    probe
  serial: imx: reformat and cleanup copyright header
  serial: imx: fix comment about which machines use the i.MX21 type
  serial: imx: drop support for IRDA
  serial: imx: add support for half duplex rs485

 drivers/tty/serial/imx.c                 | 311 ++++++++++++-------------------
 include/linux/platform_data/serial-imx.h |   5 -
 2 files changed, 119 insertions(+), 197 deletions(-)

-- 
2.1.4
