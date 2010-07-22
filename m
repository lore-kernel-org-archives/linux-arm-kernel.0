From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Jul 2010 12:47:18 +0100
Subject: [PATCH 0/9] CM's patches for the next merging window(s)
In-Reply-To: <20100722100326.GC31293@n2100.arm.linux.org.uk>
References: <20100719133050.24290.70856.stgit@e102109-lin.cambridge.arm.com>
	<20100722100326.GC31293@n2100.arm.linux.org.uk>
Message-ID: <1279799238.9564.55.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-07-22 at 11:03 +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 19, 2010 at 02:43:57PM +0100, Catalin Marinas wrote:
> > This is a series of patches I maintain in my tree at (the 'rebased'
> > branch for individual patches or 'master' for a merge-friendly branch):
> 
> I think patches 2 through 9 are fine.

Thanks. I'll push them to -next. Since some of these patches would be
useful to merge in 2.6.36-rc1, please let me know which of them you'd
like in the patch system.

> I think you and Tony need to discuss patch 1 - you point out that there's
> an issue writing the TLS value after this change, and Tony's patches
> change the way that the TLS code works.  I'd like to hear that there's
> no issue if both patches were to be merged.

Is Tony's patch going into mainline for 2.6.36-rc1? I can rebase my
domains patch on top of this. Apart from some merge conflicts I don't
see an issue with the implementation. I'll repost once rebased.

-- 
Catalin
