From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Feb 2010 11:35:59 +0100
Subject: [PATCH 1/3] gpiolib: make names array and its values const
In-Reply-To: <1265620180-14150-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100203155558.GH11354@pengutronix.de>
	<1265620180-14150-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100224103559.GA15181@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

what do you think about these three patches?  Should I resend?

Best regards
Uwe

The following changes since commit 6339204ecc2aa2067a99595522de0403f0854bb8:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../viro/vfs-2.6

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git gpiolib/names

Uwe Kleine-K?nig (3):
      gpiolib: make names array and its values const
      gpiolib: a gpio is unsigned, so use %u to print it
      gpiolib: document that names can contain printk format specifiers

 drivers/gpio/gpiolib.c      |    4 ++--
 drivers/gpio/pca953x.c      |    2 +-
 include/asm-generic/gpio.h  |    6 ++++--
 include/linux/i2c/pca953x.h |    2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
