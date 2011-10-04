From: gwenhael.goavec-merou@armadeus.com (gwenhael.goavec)
Date: Tue, 4 Oct 2011 13:56:43 +0200
Subject: please add MACH_APF9328 to mach-types
In-Reply-To: <20110727082754.GT16561@pengutronix.de>
References: <20110725210859.GL16561@pengutronix.de>
	<20110727082303.GA21584@n2100.arm.linux.org.uk>
	<20110727082754.GT16561@pengutronix.de>
Message-ID: <20111004135643.26e93dda@trabucayre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This issue still does not seem fixed. Should I send a patch?

Gwenhael

On Wed, 27 Jul 2011 10:27:54 +0200
Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> On Wed, Jul 27, 2011 at 09:23:03AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Jul 25, 2011 at 11:08:59PM +0200, Uwe Kleine-K?nig wrote:
> > > mx1_defconfig currently fails to build because MACH_APF9328 is missing
> > > in arch/arm/tools/mach-types.
> > > 
> > > Can you please add it back?
> > 
> > Most people tell me the number.
> I'll interpret this as an hit to give it to you. The complete line to
> add is:
> 
> apf9328			MACH_APF9328		APF9328			906
> 
> Thanks,
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
