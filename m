From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Feb 2010 12:00:44 +0100
Subject: my i2c-patches for 2.6.34
In-Reply-To: <1258658141-30340-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1257754721-17325-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258658141-30340-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258658141-30340-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100224110044.GB15181@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ben,

this mail is the fourth try to get some comments on the pxa patches.
Can you please consider to take them for 2.6.34?  Or do you think they
need an ack by someone?

I'll resend them as a reply to this mail, or you can get them via git,
see below.

Best regards
Uwe

The following changes since commit 75ef7cdda2daa35be9e070ac8e5258759ac03d06:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../davem/net-2.6

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux-2.6.git next/i2c

Uwe Kleine-K?nig (2):
      i2c/pxa: remove unused macro
      MAINTAINERS: add i2c tree for embedded platforms

Wolfram Sang (1):
      i2c/pxa: only define 'blue_murder'-function if DEBUG is #defined

 MAINTAINERS                  |    1 +
 drivers/i2c/busses/i2c-pxa.c |   26 ++++++++++++++------------
 2 files changed, 15 insertions(+), 12 deletions(-)

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
