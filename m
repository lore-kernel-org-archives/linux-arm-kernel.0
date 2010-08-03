From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 3 Aug 2010 21:36:11 +0200
Subject: concurrent access to gpiolib on mxc.
In-Reply-To: <4C58643E.2040105@xenomai.org>
References: <4C58643E.2040105@xenomai.org>
Message-ID: <20100803193611.GA18431@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gilles,

On Tue, Aug 03, 2010 at 08:47:26PM +0200, Gilles Chanteperdrix wrote:
> the gpiolib support on mxc seems to lack protection against concurrent
> access. Is it OK for this SOC family?
	http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commitdiff;h=14cb0de

is on it's way into mainline.  Note that you need

	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6280/1

on top of it.

Does this answer your question?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
