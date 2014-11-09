From: kgene@kernel.org (Kukjin Kim)
Date: Sun, 09 Nov 2014 13:45:44 +0900
Subject: [GIT PULL 2/3 v2] 1st Round of Samsung PM updates for v3.19
In-Reply-To: <20141109000500.GA11947@quad.lixom.net>
References: <021801cff253$0374fe40$0a5efac0$@samsung.com>
 <20141104203502.GA3851@quad.lixom.net>
 <015101cff88f$e5790880$b06b1980$@kernel.org>
 <20141109000500.GA11947@quad.lixom.net>
Message-ID: <008201cffbd8$05e03080$11a09180$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Wed, Nov 05, 2014 at 09:31:49AM +0900, Kukjin Kim wrote:
> > Olof Johansson wrote:
> > > On Tue, Oct 28, 2014 at 11:00:57AM +0900, Kukjin Kim wrote:
> > > > Hi,
> > > >
> > Hi,
> >
> > > > I'm sending new pull-request for tags/samsung-pm-v2 instead of tags/samsung-pm.
> > > > Note that just added "fix build with ARM_CPU_SUSPEND=n" from Arnd, please pull.
> > > >
> > > > Thanks,
> > > > Kukjin
> > >
> > > Kukjin,
> > >
> > > The history here is somewhat odd. You've merged in cleanup and dt,
> > > and two merges of pm (one with just the extra fix from Arnd). Are the
> > > merges needed just to avoid merge conflicts? If so, we can resolve that
> > > when we merge here, that's not a problem.
> > >
> > Oops, probably I did 'checkout for-next' in my tree when I tagged
> > tags/samsung-pm-v2 :(
> >
> > > If it's needed because pm doesn't work without the dt branch also being
> > > merged in, then this is not sufficient since when bisecting, you might get
> > > only the pm branch contents and not the dt contents in some circumstances.
> > >
> > > So, please confirm which of the cases it is, and resubmit just the bare
> > > pm branch if there are no dependencies.
> > >
> > Can you please merge branch v3.19-next/pm-samsung-2 instead?
> > If you don't want to merge just branch, I'll re-send with new tag.
> >
> > Sorry for the inconvenience.
> 
> Hi,
> 
> I've merged the branch into next/soc now.
> 
Thank you so much :)

- Kukjin
