From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 1 Jan 2012 09:04:12 +0800
Subject: [GIT PULL] tty: serial: imx changes for 3.3
Message-ID: <20120101010411.GB13061@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

I collected a few imx tty/serial changes below for 3.3.  Can you please
take a look and consider to pull the branch for 3.3 if it looks all
good to you?

Regards,
Shawn

The following changes since commit 5f0a6e2d503896062f641639dacfe5055c2f593b:

  Linux 3.2-rc7 (2011-12-23 21:51:06 -0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/serial

Dirk Behme (1):
      imx: Add save/restore functions for UART control regs

Eric Miao (1):
      tty: serial: imx: move del_timer_sync() to avoid potential deadlock

Fabio Estevam (1):
      tty: serial: imx: Allow UART to be a source for wakeup

Saleem Abdulrasool (1):
      imx: add polled io uart methods

Uwe Kleine-K?nig (2):
      serial/imx: propagate error from of_alias_get_id instead of using -ENODEV
      serial/imx: let probing fail for the dt case without a valid alias

 drivers/tty/serial/imx.c |  146 +++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 132 insertions(+), 14 deletions(-)
