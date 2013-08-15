From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Aug 2013 18:20:01 +0100
Subject: [GIT PULL] CCI PMU driver for 3.12
In-Reply-To: <87haeskn1o.fsf@kernel.org>
References: <20130812172447.GG25995@mudshark.cambridge.arm.com>
 <87haeskn1o.fsf@kernel.org>
Message-ID: <20130815172001.GB1784@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Aug 14, 2013 at 09:57:55PM +0100, Kevin Hilman wrote:
> Will Deacon <will.deacon@arm.com> writes:
> >
> > Please can you pull the following perf update for 3.12? I was hoping to have
> > some unwinding improvements too, but I've not had a chance to complete that
> > work, so it's just the single patch from Punit to add support for the PMU
> > driver on the CCI.
> >
> > Apologies for sending this post -rc5, but I've been travelling for the past
> > week and had some issues testing the driver myself. If you're snowed under,
> > feel free to queue this for 3.13 instead.
> 
> I'd like to see a reviewed-by or acked-by from a DT maintainer before
> pulling this.

That's fair enough; they've been quiet on the iterations of this patch so
far. However, it looks like a conversation has kicked off on the back of
this pull request:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/192192.html

so I'll wait for that to settle down, then I'll send you another pull (which
I suspect you will want to delay until 3.13).

Cheers,

Will
