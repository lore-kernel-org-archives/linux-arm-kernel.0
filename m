From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 12 Jul 2011 11:57:36 +0200
Subject: Pull request for LPC32xx
Message-ID: <20110712095735.GC1953@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I hope it is okay that I send these pull-requests, but Kevin seems to be busy.
He has tested the patches before, though. They are quite trivial, I think, yet
this is the third try to get them included. It is mainly adding devices for
which the drivers have been accepted meanwhile.

Thanks,

   Wolfram

The features:
=============

The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:

  Linux 3.0-rc7 (2011-07-11 16:51:52 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/wsa/linux-2.6.git lpc32xx-for-3.1-features

Wolfram Sang (2):
      arm: lpc32xx: add tsc-device
      arm: lpc32xx: add rtc-device

 arch/arm/mach-lpc32xx/clock.c  |    2 +-
 arch/arm/mach-lpc32xx/common.c |   42 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/common.h |    2 +
 3 files changed, 45 insertions(+), 1 deletions(-)



The bugfix:
===========

The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:

  Linux 3.0-rc7 (2011-07-11 16:51:52 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/wsa/linux-2.6.git lpc32xx-for-3.1-bugfixes

Wolfram Sang (1):
      arm: lpc32xx: clock: use bool logic instead of binary

 arch/arm/mach-lpc32xx/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110712/30776079/attachment.sig>
