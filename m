From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 30 Mar 2010 18:53:59 +0200
Subject: Git pull request: ARM LPC32XX architecture
In-Reply-To: <20100314150024.GA21817@n2100.arm.linux.org.uk>
References: <a08234131003121244t6f914926s3ea75e98c017686a@mail.gmail.com>
	<20100312210353.GB1146@n2100.arm.linux.org.uk>
	<20100313155053.GU8885@pengutronix.de>
	<20100314150024.GA21817@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F8097663767C@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: Git pull request: ARM LPC32XX architecture
> 
> On Sat, Mar 13, 2010 at 04:50:53PM +0100, Robert Schwebel wrote:
> > Hi Russell,
> >
> > On Fri, Mar 12, 2010 at 09:03:53PM +0000, Russell King - ARM Linux wrote:
> > > However, what I do want to avoid this time around is having an
> > > excessive number of merge conflicts, which may require a pause to
> > > sort out (and I might ask people to bring their trees up to date
> > > first.)
> >
> > Hmm, maybe we should make sure that more of the arm-sub-trees are in
> > linux-next; would that make the situation easier? If all of the trees
> > you pull are in next, at least in theory it should be a matter of
> > pulling them in the right order and send a pull request to linus.
> 
> It's less of a problem if people follow the ordering of the machine
> dependent bits for arch/arm/Makefile and arch/arm/Kconfig - things
> tend to go horribly wrong when they don't, and git even gets confused.
> 
> The solution to that is to ensure that these *stay* sorted and refuse
> to merge anything which breaks the sorting.  Yes, there'll still be
> occasional merge conflicts, but keeping these things sorted should
> result in the resolutions being trivial.
> 
> It all goes wrong when we end up with everyone adding to the end of
> the lists, and then I re-order it - that's the point where git silently
> guesses the resolutions wrong and we end up with, eg, two includes of
> mach-lh7a40x/Kconfig.
> 
> What I don't want to do is re-sort these files, and then have to deal
> with re-doing the sorting each time I subsequently merge a tree because
> they're based on a commit prior to that re-sort.

Hi Russell,

Is there anything I can do to help move these along? It's not a rush job
to get these into the tree, but I would like to start getting other
changes and drivers submitted based on this work.

If I can help, please let me know!

thanks,
Kevin
