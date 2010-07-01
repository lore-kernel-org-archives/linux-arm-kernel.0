From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 1 Jul 2010 11:56:34 +0200
Subject: Pending patches for -rc
In-Reply-To: <20100630101223.GA24284@n2100.arm.linux.org.uk>
References: <20100630101223.GA24284@n2100.arm.linux.org.uk>
Message-ID: <20100701095634.GA5929@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 30, 2010 at 11:12:23AM +0100, Russell King - ARM Linux wrote:
> Given Linus' concerns about the code which is going in during the -rc
> period, and the clamp-down we had for -rc3, I've re-reviewed the
> changes which I have in my master branch.  The following changes do not
> feel like critical rc material:

I agree for the bulk of the i.MX patches. There is one patch I'd like to
have for 2.6.36, find it here:

The following changes since commit 980019d74e4b2428362b36a0506519d6d9460800:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging-2.6 (2010-06-30 15:45:59 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git imx-for-2.6.35

Daniel Mack (1):
      ARM: mx3: mx31lilly: fix build error for !CONFIG_USB_ULPI

 arch/arm/mach-mx3/mach-mx31lilly.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
