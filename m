From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 4 Nov 2009 10:00:59 +0100
Subject: [PATCH 1/2] [ARM] i2c/pxa: remove unused macro
In-Reply-To: <20091103210115.GA24955@flint.arm.linux.org.uk>
References: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091103210115.GA24955@flint.arm.linux.org.uk>
Message-ID: <20091104090059.GB23889@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Nov 03, 2009 at 09:01:15PM +0000, Russell King wrote:
> On Tue, Nov 03, 2009 at 08:03:19PM +0100, Uwe Kleine-K?nig wrote:
> > Commit
> > 
> > 	beea494 ([ARM] Remove EEPROM slave emulation from i2c-pxa driver.)
> 
> Oh great.  Some people may remember the LX code that I submitted to
> the mailing list a while back.  Removing the slave emulation buggers
> that platform up.  I do intend to submit that once the issue of where
> the PCON support should be located is resolved - which is still
> pending.
> 
> Please revert this change, thanks.
"this" means beea494 or my patch?  I'm unsure because you (Russell) are
the author of beea494.

The main reason for this series was the 2nd patch.  While creating it I
noticed that eedbg was unused.

For this second patch (only defining i2c_pxa_scream_blue_murder if DEBUG
is #defined) should I rebase it to beea494^ or should I revert beea494
and put it on top of the reverted beea494?

Thanks
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
