From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 29 Jun 2011 11:42:13 +0100
Subject: [PATCHv2 0/4] ARM: pmu: improve PMU type identification
In-Reply-To: <20110629093652.GH1181@e102144-lin.cambridge.arm.com>
References: <1308148804-5518-1-git-send-email-mark.rutland@arm.com>
	<20110629092622.GL21898@n2100.arm.linux.org.uk>
	<20110629093652.GH1181@e102144-lin.cambridge.arm.com>
Message-ID: <20110629104213.GC2589@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 10:36:53AM +0100, Will Deacon wrote:
> Russell,
> 
> On Wed, Jun 29, 2011 at 10:26:22AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Jun 15, 2011 at 03:40:00PM +0100, Mark Rutland wrote:
> > > can be used similarly (the macros make entries look identical apart from the
> > > {plat,of} prefix). This allows us to stop (ab)using platform_device::id, and
> > > should allow for easier addition/modification of PMU driver bindings.
> > > 
> > > BSPs need no longer care about the Type of PMUs they register; as long as a
> > > binding exists the type will be assigned correctly.
> > 
> > Could someone please look at adding an entry to the MAINTAINERS file
> > for the ARM PMU stuff, so we know who should be looking after this stuff?
> 
> I'm happy to maintain this stuff if nobody has any objections.

No objections from me, I think that sounds like a very good idea!

Jamie
