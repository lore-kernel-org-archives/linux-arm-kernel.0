From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 13 Sep 2012 10:40:58 +0300
Subject: [PATCHv7 07/12] ARM: OMAP4: PM: put all domains to OSWR during
 suspend
In-Reply-To: <87sjamsuom.fsf@deeprootsystems.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
 <1342704392-23657-8-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1207190842310.432@utopia.booyaka.com>
 <1342711907.4672.153.camel@sokoban>
 <alpine.DEB.2.00.1207191726090.14390@utopia.booyaka.com>
 <87sjamsuom.fsf@deeprootsystems.com>
Message-ID: <1347522058.10702.143.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-09-12 at 16:11 -0700, Kevin Hilman wrote:
> Paul Walmsley <paul@pwsan.com> writes:
> 
> [...]
> 
> >
> > It kind of looks to me like there are two or three separate sets within 
> > the series.  My feeling is that Kevin should take the first two, then I 
> > should take the rest other than 6 and 7.  Then once those are queued, 
> > we can pull in 6 and 7.  Does that make sense to you?
> >
> 
> Looks like 1, 2 & 7 are needed for OSWR, and the rest can go now via
> Paul.
> 
> Tero, can create a new OSWR series including 1, 2 & 7?  Can you also
> refresh it against Jean's latest functional power state series (v6)?

Yes, I already have these patches locally available. I'll just refresh
them against Paul's minor tweaks on rest of the patches and re-post.

-Tero
