From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 25 May 2011 10:28:41 -0400 (EDT)
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <20110525075902.GH30799@atomide.com>
References: <201105181047.17309.arnd@arndb.de>
	<BANLkTi=xzrLhHTBynWf4huA9EusfaDwPbA@mail.gmail.com>
	<20110525075902.GH30799@atomide.com>
Message-ID: <alpine.LFD.2.00.1105251021550.3207@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 May 2011, Tony Lindgren wrote:

> * Catalin Marinas <catalin.marinas@arm.com> [110518 17:49]:
> > Arnd,
> > 
> > On 18 May 2011 09:47, Arnd Bergmann <arnd@arndb.de> wrote:
> > > This is the draft plan for maintaining the ARM subarchitectures in a common
> > > tree, as a way to help coordinate the upstream merging of the
> > > arch/arm/{plat,mach}-* changes into Linus' tree.
> > 
> > For clarification - the aim of this subarchitecture group is not only
> > to coordinate the upstream merging but also take an active (primary)
> > role in consolidating the existing code across various
> > subarchitectures under arch/arm/.
> 
> It's good to see organized effort on consolidating the code.
> And Linaro is probably the best place to organize this effort.
> 
> Naturally I assume that you guys won't be merging any platform
> specific patches without proper acks from the platform maintainers:

Obviously.  In fact I expect platform maintainers to be the ones pushing 
their merge requests to us.  This is not going to replace the job you're 
currently doing.

> Arnd, do you want to do a practise run with pulling in the omap
> code and merging to Linus for this merge window?

No.  We'll start merging stuff once this merge window is over.  In other 
words, you are still on your own for the current one.

Also, I want stuff merged in this subarch tree way before the next merge 
window opens on a continuous basis, not in a big rush before it opens, 
or worse, while it is already open.


Nicolas




> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
