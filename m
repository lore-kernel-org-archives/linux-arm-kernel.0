From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Wed, 04 Aug 2010 07:55:56 +0200
Subject: concurrent access to gpiolib on mxc.
In-Reply-To: <20100803193611.GA18431@pengutronix.de>
References: <4C58643E.2040105@xenomai.org>
	<20100803193611.GA18431@pengutronix.de>
Message-ID: <4C5900EC.9010105@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:
> Hi Gilles,
> 
> On Tue, Aug 03, 2010 at 08:47:26PM +0200, Gilles Chanteperdrix wrote:
>> the gpiolib support on mxc seems to lack protection against concurrent
>> access. Is it OK for this SOC family?
> 	http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commitdiff;h=14cb0de
> 
> is on it's way into mainline.  Note that you need
> 
> 	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6280/1
> 
> on top of it.
> 
> Does this answer your question?

Yes. Thanks. Sorry for the noise.

-- 
					    Gilles.
