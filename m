From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 23 Jan 2013 10:58:13 +0100
Subject: [PATCH REBASE 0/6] i2c: omap: misc changes
In-Reply-To: <20130114191628.GB9402@arwen.pp.htv.fi>
References: <1355502849-9289-1-git-send-email-balbi@ti.com>
 <20130114191628.GB9402@arwen.pp.htv.fi>
Message-ID: <20130123095813.GG3767@nekote.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 09:16:28PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Dec 14, 2012 at 06:34:03PM +0200, Felipe Balbi wrote:
> > this is just a rebase of the previous series adding support
> > for amount of bytes transferred upon NACK.
> > 
> > Well, actually the patches implementing transferred bytes
> > reporting aren't here because we need to discuss how to move
> > forward.
> > 
> > This series is just a preparation for that, but it also
> > contains a at least one bugfix.
> > 
> > Each and every patch has been tested with pandaboard, it
> > would be nice to get Tested-bys from other folks on other
> > platforms before pushing this for v3.9 (there's more than
> > enough time for that).
> > 
> > Note that we're also dropping b_hw flag since that becomes
> > useless since we'll never set STT and STP together anymore.
> > 
> > Give it a good round of test, please.
> 
> Wolfram, I have these patches rebased on top of v3.8-rc3 if you wish.
> Let me know if I should resend them (again).

Yes, please rebase on top of Aaro's patches (probably in v3.8-rc5).
Patches look mostly good, have to think more about what Patch 5 is
wanting to achieve at the end of the day.
