From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 14 Jul 2011 11:09:47 -0700
Subject: [PATCH] i2c: tegra: Use engineering names in DT compatible
	property
In-Reply-To: <CACxGe6tojgLSmHTxzGn3hZZVqiR_z6xbWrazYekm0TwQoWK5eA@mail.gmail.com>
References: <1309897306-22953-1-git-send-email-swarren@nvidia.com>
	<20110706053941.GE9978@ponder.secretlab.ca>
	<74CDBE0F657A3D45AFBB94109FB122FF049E834757@HQMAIL01.nvidia.com>
	<CACxGe6tojgLSmHTxzGn3hZZVqiR_z6xbWrazYekm0TwQoWK5eA@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049E834A2E@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote at Wednesday, July 13, 2011 5:34 PM:
> On Thu, Jul 14, 2011 at 2:59 AM, Stephen Warren <swarren@nvidia.com> wrote:
...
> > I don't believe anyone ever sent a patch to Ben to add tegra_i2c_of_match
> > to the driver; the OF support patch didn't include that part of the code.
> > As such, Ben can't yet apply this to his tree. (Although I note this patch
> > is in Grant's /arm and /test trees, which is probably good enough for now).
> 
> Hmmm, I thought it had been done.  It certainly is ready to go in.  Do
> you want to put together a roll-up patch that includes all the
> required changes and post it again? (although double check linux-next
> first).

When John Bonesio posted the patch to add DT support to i2c-tegra.c, the first
version of the patch was missing the match table chunk. A few days later, an
updated version was posted that added the missing chunk; see:

http://groups.google.com/group/linux.kernel/browse_thread/thread/d2596e8dee819b0f/c8aa04183ea2331e?show_docid=c8aa04183ea2331e

It looks like the first version of the patch has actually been applied to Ben's
next-i2c branch rather than the updated version.

I guess it's simplest if I just post a patch that adds the missing chunk based
on the latest next-i2c tree. I'll go do that.

-- 
nvpublic
