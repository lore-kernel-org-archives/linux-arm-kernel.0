From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 1 Feb 2011 17:47:05 +0100
Subject: [PATCH 3/9] Add a mfd IPUv3 driver
In-Reply-To: <20110201125129.GA2027@pengutronix.de>
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
	<1292842127-21406-4-git-send-email-s.hauer@pengutronix.de>
	<20110201105127.GA10128@sortiz-mobl>
	<20110201105909.GS9041@pengutronix.de>
	<20110201114453.GC10128@sortiz-mobl>
	<20110201115125.GE31216@n2100.arm.linux.org.uk>
	<87wrlkyn3s.fsf@lechat.rtp-net.org>
	<20110201125129.GA2027@pengutronix.de>
Message-ID: <20110201164705.GG1147@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Feb 01, 2011 at 01:51:29PM +0100, Sascha Hauer wrote:
> On Tue, Feb 01, 2011 at 01:07:35PM +0100, Arnaud Patard wrote:
> > Hi,
> > 
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > 
> > > On Tue, Feb 01, 2011 at 12:44:54PM +0100, Samuel Ortiz wrote:
> > >> Ok, so would moving it do drivers/video/ make sense ?
> > >
> > > Isn't that for framebuffer drivers?
> > 
> > For now, the ipu driver is used for framebuffer on imx5.
> 
> But it will hopefully be used for camera aswell.
> 
> How about arch/arm/plat-mxc?
I'm sure Linus would object.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
