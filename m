From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Jul 2011 18:28:29 +0100
Subject: [PATCH v4 00/40] ARM: mm: Add generic macros for declaring
	various CPU structs
In-Reply-To: <20110707163755.GH2486@arm.com>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
	<20110707162218.GA20403@n2100.arm.linux.org.uk>
	<20110707163755.GH2486@arm.com>
Message-ID: <20110707172829.GC13534@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave,

On Thu, Jul 07, 2011 at 05:37:55PM +0100, Dave Martin wrote:
> On Thu, Jul 07, 2011 at 05:22:18PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Jul 07, 2011 at 03:27:07PM +0100, Dave Martin wrote:
> > > This series adds macros for declaring some CPU-related structured
> > > defined in assembler, and ports the various processors, cache and
> > > tlb implementations to use the macros.
> > 
> > I think this now looks fine - I don't have time to test it at the moment
> > 600+ messages on the list yesterday (I spent most of yesterday _only_
> > replying to email), new large patch sets on the list today, and
> > struggling to test some of these changes...
> > 
> > (It's no wonder people feel that they get ignored - generally if I don't
> > process things on the day they're sent, I hardly go looking back through
> > my mailbox... it's only Will's pull request which made me go back and
> > look at yours.)
> 
> Thanks for taking a look anyhow.
> 
> Unfortunately this series was a lot of noise, but I didn't like to
> merge those patches together, due to the many orthogonal changes between
> the different CPUs.
> 
> Are you happy for these patches to appear in Will's pull request now?
> I'm as confident as I can reasonably be that they don't break anything,
> due to the policy of not changing the resulting .o files in any material
> way.  I've also tested on a couple of real platforms (though by no
> means the full set).

Since Russell has stated that he thinks this code looks fine, I'll recreate
my for-rmk branch tomorrow and send a new pull request.

Will
