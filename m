From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 27 Jul 2011 10:27:54 +0200
Subject: please add MACH_APF9328 to mach-types
In-Reply-To: <20110727082303.GA21584@n2100.arm.linux.org.uk>
References: <20110725210859.GL16561@pengutronix.de>
	<20110727082303.GA21584@n2100.arm.linux.org.uk>
Message-ID: <20110727082754.GT16561@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2011 at 09:23:03AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 25, 2011 at 11:08:59PM +0200, Uwe Kleine-K?nig wrote:
> > mx1_defconfig currently fails to build because MACH_APF9328 is missing
> > in arch/arm/tools/mach-types.
> > 
> > Can you please add it back?
> 
> Most people tell me the number.
I'll interpret this as an hit to give it to you. The complete line to
add is:

apf9328			MACH_APF9328		APF9328			906

Thanks,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
