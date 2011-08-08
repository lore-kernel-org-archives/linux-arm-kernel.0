From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 8 Aug 2011 11:50:47 -0600
Subject: [PATCH 2/2] arm/tegra: Delete irq_to_gpio
In-Reply-To: <CAOesGMi2CXyAoy56-SdaD5YFzXW6W4wP6mnH+bVvRR3i_Mhk2A@mail.gmail.com>
References: <1312582534-10871-1-git-send-email-swarren@nvidia.com>
	<1312582534-10871-2-git-send-email-swarren@nvidia.com>
	<20110806174519.GB31966@ponder.secretlab.ca>
	<74CDBE0F657A3D45AFBB94109FB122FF049F172168@HQMAIL01.nvidia.com>
	<CAOesGMi2CXyAoy56-SdaD5YFzXW6W4wP6mnH+bVvRR3i_Mhk2A@mail.gmail.com>
Message-ID: <CACxGe6ubndfYNxgRfrLtCZ8cP0FddwTpG_FBZKXVZb0OHJVt6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Aug 8, 2011 8:26 AM, "Stephen Warren" <swarren@nvidia.com> wrote:
>
> Grant Likely wrote at Saturday, August 06, 2011 11:45 AM:
> > On Fri, Aug 05, 2011 at 04:15:34PM -0600, Stephen Warren wrote:
> > > irq_to_gpio is deprecated and in the process of being removed. Make that
> > > happen now for ARM Tegra.
> > >
> > > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> >
> > Applied both. ?Thanks.
>
> Didn't you want an Ack by a Tegra maintainer first?

It looks like a pretty low risk change.? I didn't see much risk in
picking it up and getting it off my plate.? I can always pull things
back out of my tree if someone complains.  I'll add Olof's ack before
it gets into linux-next.

>
> I assume they were both applied to gpio-next (although a fresh fetch ?of that
> doesn't show the commits)

I can't push it out until after 3.1-rc1 is released because it is
targeted at 3.2 now.

g.
