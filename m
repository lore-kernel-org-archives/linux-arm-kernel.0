From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Mar 2015 13:49:33 +0000
Subject: Request for additional arm64 branch in linux-next
In-Reply-To: <20150326111055.273aa644@canb.auug.org.au>
References: <20150325172002.GN24636@arm.com>
 <20150326111055.273aa644@canb.auug.org.au>
Message-ID: <20150326134932.GD2805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 12:10:55AM +0000, Stephen Rothwell wrote:
> On Wed, 25 Mar 2015 17:20:03 +0000 Will Deacon <will.deacon@arm.com> wrote:
> > We've got a series of patches introducing ACPI support for arm64 that
> > are tentatively targetting the 4.1 merge window. Whilst there are
> > face-to-face discussions set to happen in the next day or so around this
> > topic, could you please pull this into linux-next under the assumption
> > that we decide to go ahead for mainline inclusion?
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/acpi
> > 
> > I've kept the series separate from the usual arm64 branch (for-next/core)
> > but they merge without conflicts. Merging with today's next, I see two
> > trivial Kconfig conflicts (resolution below).
> 
> Added from today (and thanks for the hints).  Will this be merged via
> another tree, or go directly to Linus?

Thank, Stephen. Yes, we've been collecting Acks for a while now, so the
plan is to send this to Linus as an extra arm64 pull request.

Will
