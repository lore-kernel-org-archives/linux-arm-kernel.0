From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 29 Jan 2011 22:51:41 +0100
Subject: [RFC] add pwmlib support
In-Reply-To: <20110129213821.0e51dc32@endymion.delvare>
References: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
	<20110129213821.0e51dc32@endymion.delvare>
Message-ID: <20110129215141.GA3493@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > code is inspired by gpiolib support and tested using the backlight pwm
							     ^^^^^^^^^
> So I believe that hwmon drivers are out of scope for pwmlib. Which
> makes me wonder what you intend to do with pwmlib (back to my first
> question...) as the only use I know of for PWM signals in computers is
> for fan control.

It was meant for backlight control (was mentioned very indirectly).
I also pointed him to Bill's implementation, too.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110129/1f089d13/attachment.sig>
