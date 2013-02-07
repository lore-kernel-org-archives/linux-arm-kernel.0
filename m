From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Feb 2013 10:02:39 +0000
Subject: [GIT PULL 4/4] mach-virt platform code for 3.9
In-Reply-To: <5112D75A.1000900@gmail.com>
References: <1359986131-13034-1-git-send-email-will.deacon@arm.com>
 <1359986131-13034-4-git-send-email-will.deacon@arm.com>
 <5112D75A.1000900@gmail.com>
Message-ID: <20130207100239.GA15387@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 10:21:14PM +0000, Rob Herring wrote:
> On 02/04/2013 07:55 AM, Will Deacon wrote:
> > NOTE: I'm not suggesting you pull this one as it stands -- see below!
> >
> > This is the last batch from me (Marc is dealing with vgic and virtual
> > timers) and introduces support for mach-virt. This depends on:
> >
> >       - for-arm-soc/arch-timers (third pull request in this series)
> >       - for-rmk/virt/psci (already pulled)
> >       - irqchip/gic-vic-move (an arm-soc branch)
> >
> > As a result, the diffstat is atrocious so it would be better if you
> > could create a branch merging the above dependendies, which I could
> > rebase onto (there's actually only two patches here).
> 
> It would be good to see this based on Arnd's patch to make some of the
> mach function ptrs optional and "xen,xenvm" moved from VExpress to this.

I'm not sure what state that patch is in, but I'm happy to fix mach-virt up
once Arnd's patch is queued.

> This will also break with the sys_timer removal, so yet another dependency.

Indeed... what I could really do with is an arm-soc branch with all the
dependencies, then I can just rebase onto that and fix things up appropriately.

Will
