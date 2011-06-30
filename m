From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Jun 2011 22:51:56 +0100
Subject: [PATCH 11/23] ARM: entry: avoid enabling interrupts in
	prefetch/data abort handlers
In-Reply-To: <20110630092702.GS21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
	<E1Qbqyh-0002Fh-3Y@rmk-PC.arm.linux.org.uk>
	<20110629200522.GB12421@e102144-lin.cambridge.arm.com>
	<20110630092702.GS21898@n2100.arm.linux.org.uk>
Message-ID: <20110630215156.GC11011@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 10:27:02AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 29, 2011 at 09:05:23PM +0100, Will Deacon wrote:
> > Could you also update the comments for this function too please? There's one
> > immediately before the function that states we are called with preemption
> > disabled and there's another one where we re-enable preemption stating that
> > it was disabled by the low-level exception handling code.
> 
> I'll change the one before the function thusly s/preemption/interrupts/ 
> and remove the other entirely because it no longer serves much purpose.
> Ok?

Sounds good to me, you add my ack with those changes.

Thanks,

Will
