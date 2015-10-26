From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 26 Oct 2015 15:17:09 +0000
Subject: [PATCH] arm64: dts: Add idle-states for Juno
In-Reply-To: <1445868751.2807.21.camel@linaro.org>
References: <1430402268.2868.20.camel@linaro.org>
 <9hheggnca1y.fsf@e105922-lin.cambridge.arm.com>
 <1445868751.2807.21.camel@linaro.org>
Message-ID: <20151026151709.GA16145@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 02:12:31PM +0000, Jon Medhurst (Tixy) wrote:
> On Thu, 2015-10-22 at 14:22 +0100, Punit Agrawal wrote:
> > "Jon Medhurst (Tixy)" <tixy@linaro.org> writes:
> > 
> > > From: Jon Medhurst <tixy@linaro.org>
> > >
> > > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > 
> > Apologies for resurrecting an old thread.
> > 
> > Following the discussion on this thread, even though certain concerns
> > were raised, there wasn't any objection to $SUBJECT being merged.
> > 
> > I don't see this patch in any tree; perhaps it's slipped through the
> > cracks.
> 
> It did slip through the cracks. Lorenzo's last comment was "I am fine
> with enabling the idle states, I need to review and test the idle states
> DT data in the patch first though." and I didn't chase things up.
> 
> The patch will need refreshing to add idle for Juno r1. Which will then
> probably resurrect the discussion about where the numbers come from for
> residency times, and are the same ones for r0 valid on r1 (and r2?).
> 
> In an effort to forestall that I would say: does anyone actually care if
> the values are optimal? Juno is a reference platform and powered off
> mains, so tuning for the optimum power consumption is pretty pointless.
> But because it _is_ used as a reference by people it should at least
> have these features enabled, to serve as an example, and for test
> coverage.

I agree with you here, let me check the entry/exit latencies again
to make sure they are reasonably set-up, it is 4.5 material anyway.

Thanks,
Lorenzo
