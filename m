From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 22 Jan 2010 17:56:49 +0100
Subject: [PATCH] pcmcia/at91_cf: don't redefine SZ_2K
In-Reply-To: <cd73a99e0912231226r49dd53b8wfd7555b3db08a712@mail.gmail.com>
References: <1261343434-3920-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091222152827.GB17191@n2100.arm.linux.org.uk>
	<20091222162827.GA20681@pengutronix.de>
	<cd73a99e0912231226r49dd53b8wfd7555b3db08a712@mail.gmail.com>
Message-ID: <20100122165649.GC13718@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2009 at 10:26:56PM +0200, Andrew Victor wrote:
> hi,
> >> Have you checked whether everything which uses at91_cf still builds after
> >> this patch has been applied (eg, AVR32 stuff?)
> 
> > I wasn't aware that the driver is used on AVR32, too.
> 
> I don't think the AVR32 arch uses this driver.  So the patch should be
> fine to apply.
I assume this is an Ack?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
