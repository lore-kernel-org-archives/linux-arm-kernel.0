From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 10 Oct 2011 11:30:10 +0200
Subject: [PATCH 6/9] ARM: SPMP8000: Add pwm driver
In-Reply-To: <CAKnu2MocUpNwK5n3sq=5+n0vZEO-JRz+PAJQtE7yX3ZQ8-wq1Q@mail.gmail.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-7-git-send-email-zoss@devai.org>
	<CAKnu2MocUpNwK5n3sq=5+n0vZEO-JRz+PAJQtE7yX3ZQ8-wq1Q@mail.gmail.com>
Message-ID: <20111010093010.GP31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 03:50:51AM +0200, Linus Walleij wrote:
> 2011/10/9 Zoltan Devai <zoss@devai.org>:
> 
> > Signed-off-by: Zoltan Devai <zoss@devai.org>
> > ---
> > ?arch/arm/mach-spmp8000/pwm.c | ?246 ++++++++++++++++++++++++++++++++++++++++++
> > ?1 files changed, 246 insertions(+), 0 deletions(-)
> > ?create mode 100644 arch/arm/mach-spmp8000/pwm.c
> 
> Also PWM should have its own subsystem, sadly that is an area
> where discussions about the patches for generic PWM in
> drivers/pwm/ by Sascha Hauer seem to have stalled recently. :-(
> 
> Those we have tend to live in drivers/misc/ and drivers/mfd/
> which is not good.
> 
> Kudos to Sascha for trying to solve the mess, we need more
> subsystems...

Thanks, I'll respin these patches when I find the time. In the mean
time if anyone wants to work on this my latest branch is here:

git://git.pengutronix.de/git/imx/linux-2.6.git pwmlib

It contains the pwm framework and converts most in tree drivers to
the new framework.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
