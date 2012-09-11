From: horms@verge.net.au (Simon Horman)
Date: Tue, 11 Sep 2012 18:03:14 +0900
Subject: [GIT] Renesas ARM-based SoC: pmu/cleanup for 3.7
In-Reply-To: <20120911084914.GB5372@mudshark.cambridge.arm.com>
References: <1347350727-11962-1-git-send-email-horms@verge.net.au>
 <20120911084914.GB5372@mudshark.cambridge.arm.com>
Message-ID: <20120911090314.GA25322@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 09:49:14AM +0100, Will Deacon wrote:
> On Tue, Sep 11, 2012 at 09:05:25AM +0100, Simon Horman wrote:
> > Hi Will,
> 
> Hi Simon,
> 
> > please consider the following changes from Kobayashi-san
> > for the pmu/cleanup branch.
> 
> Thanks for this. It probably makes more sense for the arm-soc guys to pull
> it in directly, rather than me send it as another pull request.

Sorry, I was a bit confused about who does the pulling,
naturally that is fine by me.

> 
> Arnd, Olof -- can you pull this into an shmobile perf branch please?
> 
> Will
> 
> > ----------------------------------------------------------------
> > The following changes since commit 051f1b13144dd8553d5a5104dde94c7263ae3ba7:
> > 
> >   ARM: perf: move irq registration into pmu implementation (2012-08-23 11:35:52 +0100)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git pmu/cleanup
> > 
> > for you to fetch changes up to e433d4440bf7dd5955a4616cfb9bffd1ec6ab839:
> > 
> >   ARM: shmobile: emev2: enable PMU(Performance Monitoring Unit) (2012-09-11 16:27:41 +0900)
> > 
> > ----------------------------------------------------------------
> > Tetsuyuki Kobayashi (2):
> >       ARM: shmobile: sh73a0: enable PMU(Performance Monitoring Unit)
> >       ARM: shmobile: emev2: enable PMU(Performance Monitoring Unit)
> > 
> >  arch/arm/configs/kzm9d_defconfig      |    1 +
> >  arch/arm/configs/kzm9g_defconfig      |    1 +
> >  arch/arm/mach-shmobile/setup-emev2.c  |   21 +++++++++++++++++++++
> >  arch/arm/mach-shmobile/setup-sh73a0.c |   21 +++++++++++++++++++++
> >  4 files changed, 44 insertions(+)
> 
