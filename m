From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 26 May 2011 18:32:17 +0200
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <1306426823.27474.241.camel@e102391-lin.cambridge.arm.com>
References: <1306260792.27474.133.camel@e102391-lin.cambridge.arm.com>
	<1306272750.2497.79.camel@laptop> <1306343335.21578.65.camel@twins>
	<1306358128.21578.107.camel@twins>
	<BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
	<1306405979.1200.63.camel@twins>
	<1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>
	<20110526154508.GA13788@redhat.com> <1306425584.2497.81.camel@laptop>
	<1306426148.2497.83.camel@laptop>
	<1306426823.27474.241.camel@e102391-lin.cambridge.arm.com>
Message-ID: <1306427537.2497.86.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-26 at 17:20 +0100, Marc Zyngier wrote:
> 
> Doesn't look very good here. The serial console basically locks up as
> soon as the system gets busy, even if the kernel compilation seem to
> progress at a decent pace. 


OK, I'll leave the one that worked queued up for this release. If we can
come up with a better alternative we can try for the next release, that
should give us ample time to test things and get us a working kernel
now ;-)
