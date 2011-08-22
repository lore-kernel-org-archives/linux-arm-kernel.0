From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 22 Aug 2011 10:33:29 +0200
Subject: 46dcfc8 (ARM: Update mach-types) removes used machine types
In-Reply-To: <20110822081748.GJ12028@n2100.arm.linux.org.uk>
References: <20110822081000.GA16557@pengutronix.de>
	<20110822081748.GJ12028@n2100.arm.linux.org.uk>
Message-ID: <20110822083329.GB16557@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 09:17:49AM +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 22, 2011 at 10:10:00AM +0200, Uwe Kleine-K?nig wrote:
> > Hello Russell,
> > 
> > your commit 46dcfc8 that is in today's next among other changes does:
> > 
> > -eukrea_cpuimx25sd      MACH_EUKREA_CPUIMX25    EUKREA_CPUIMX25 2820
> > -eukrea_cpuimx35sd      MACH_EUKREA_CPUIMX35    EUKREA_CPUIMX35 2821
> > 
> > These two are both marked as "mainlined" on
> > http://www.arm.linux.org.uk/developer/machines/ and both are actually
> > used (arch/arm/mach-imx/mach-{eukrea_cpuimx25,cpuimx35.c})
> > 
> > Can you please add them back? Maybe it's worth to double-check the other
> > deletions?!
> 
> No.  They're removed because they're broken (look at them) - I've added
> additional checks so I don't have to waste _significant_ time fixing
> the entries time and time again.
> 
> The requirement is that the machine_is_xxx() must match the MACH_xxx
> parts.  If they don't, they will not exist in future updates.
Ah, I wasn't aware of that requirement.

Eric, these machine types are owned by you. Do you care to follow up?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
