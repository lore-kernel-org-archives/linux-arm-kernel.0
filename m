From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Nov 2009 19:06:51 +0000
Subject: [PATCH 1/2] [ARM] i2c/pxa: remove unused macro
In-Reply-To: <20091103221249.GI13398@fluff.org.uk>
References: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091103210115.GA24955@flint.arm.linux.org.uk>
	<20091103221249.GI13398@fluff.org.uk>
Message-ID: <20091104190651.GB518@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2009 at 10:12:49PM +0000, Ben Dooks wrote:
> On Tue, Nov 03, 2009 at 09:01:15PM +0000, Russell King wrote:
> > On Tue, Nov 03, 2009 at 08:03:19PM +0100, Uwe Kleine-K?nig wrote:
> > > Commit
> > > 
> > > 	beea494 ([ARM] Remove EEPROM slave emulation from i2c-pxa driver.)
> > 
> > Oh great.  Some people may remember the LX code that I submitted to
> > the mailing list a while back.  Removing the slave emulation buggers
> > that platform up.  I do intend to submit that once the issue of where
> > the PCON support should be located is resolved - which is still
> > pending.
> > 
> > Please revert this change, thanks.
> 
> Would you like it reverted in the next merge window, or when the
> LX code is actually added?

Actually, the change was correct, and was part of the LX patchset - I just
misremembered where stuff was with it.

> I'll NAK any changes to remove the eedbg() for the moment.

That change is also fine, consider it acked:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Sorry for the noise.
