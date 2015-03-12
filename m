From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Mar 2015 17:27:06 +0100
Subject: [RFC PATCH 00/18] ARM: msm multiplatform support
In-Reply-To: <20150307031212.GA8434@fifo99.com>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
 <20150307031212.GA8434@fifo99.com>
Message-ID: <15639509.lt3n5ESUUB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 07 March 2015 03:12:12 dwalker at fifo99.com wrote:
> On Wed, Mar 04, 2015 at 08:32:54PM +0100, Arnd Bergmann wrote:
> > This is my final piece of the puzzle for ARMv6/v7 multiplatform
> > support. In combination with the other patches that are now
> > at git://kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
> > multiplatform-4.0-rc2 and the at91 and shmobile parts from other
> > developers, you can now build one kernel that includes all 
> > ARMv6 and ARMv7 targets we support in Linux.
> > 
> > Since mach-msm has seen very few updates over the last years,
> > it was more work to get to this point than the others, and
> > some patches are more of a band-aid than a proper solution.
> > Still, I think that each patch in the series is an improvement
> > over the status-quo and I really want to see the last one
> > merged into 4.1 and it depends on all the other ones.
> > 
> > Stephen Boyd mentioned on IRC that he has been workin on
> > a similar series, and I'm more than happy to replace some
> > of this work with patches that he has done, as long as we
> > can still have the full multiplatform support for 4.1.
> > 
> > Since a lot of the patches are nontrivial and I have not
> > been able to test any of this, I'm posting it as an RFC,
> > but I'm also very interested in people testing it.
> > 
> 
> I think I would support deleting mach-msm at this point. I did work
> on adding device tree support last year, but lost my motivation. It
> seems like the community has a tendency to attack things that
> are "old" and mach-msm seems like a constant whipping horse. I don't
> have plans for mach-msm., Qualcomm never cared about the remaining platforms
> and Google never cared either. I have no reason to care about it anymore.
> 
> If someone out there still wants the code I'm game to start actively maintaining
> it, now that it's clear David and Bryan have completely walked away. Baring someone
> coming forward it seems no one else is actively using it.

I'd like to first get my patch series merged and have that in the kernel
for one release, so we can start with this as a base if we decide to
revive it. I'm definitely fine with removing it in the following
merge window, but I'd leave that up to you.

	Arnd
