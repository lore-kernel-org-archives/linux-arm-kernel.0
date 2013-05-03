From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 May 2013 15:49:05 +0200
Subject: [GIT PULL] mailbox driver framework for v3.10 merge window
In-Reply-To: <CACRpkdYSnNeO8F-1WWN9J+pkMi6B_Qydo85QovbgWOEoDDS9Aw@mail.gmail.com>
References: <37C860A02101E749A747FA2D3C1E3C504A1971@DLEE11.ent.ti.com>
 <1407180.uGFidLMFHk@wuerfel>
 <CACRpkdYSnNeO8F-1WWN9J+pkMi6B_Qydo85QovbgWOEoDDS9Aw@mail.gmail.com>
Message-ID: <4518021.h47erc1rfT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 May 2013 15:39:42 Linus Walleij wrote:
> On Fri, May 3, 2013 at 3:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 02 May 2013 17:09:07 Suman Anna wrote:
> >>
> >> I do not know how much of an impact it is for the ST driver as the
> >> series adds the driver, and would have to wait until the RFC is sorted
> >> out otherwise.
> >
> > I think I'd prefer to drop the branch from the 3.10 queue then
> > and let you all work out a common approach for 3.11. Olof, any
> > other input?
> 
> This will block all refactoring of the PRCMU driver, which Loic
> is working on, and also Ulf Hansson's clock driver. It is basically
> the key to breaking that driver apart and distributing it out into
> the proper subsystems. Loic has a big patch series for that
> for next merge window which will then have to be postponed,
> or queued on top of the mailbox work when finished.
> 
> But maybe it's the right thing to do if the subsystem needs more
> work? I have no clear opinion on this, Loic, Ulf?

I think we can queue them together. I'm certainly fine with the
mailbox subsystem getting merged through both the mfd and arm-soc
trees to avoid conflicts.

	Arnd
