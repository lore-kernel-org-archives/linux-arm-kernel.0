From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 8 Aug 2011 07:26:00 -0700
Subject: [PATCH 2/2] arm/tegra: Delete irq_to_gpio
In-Reply-To: <20110806174519.GB31966@ponder.secretlab.ca>
References: <1312582534-10871-1-git-send-email-swarren@nvidia.com>
	<1312582534-10871-2-git-send-email-swarren@nvidia.com>
	<20110806174519.GB31966@ponder.secretlab.ca>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049F172168@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote at Saturday, August 06, 2011 11:45 AM:
> On Fri, Aug 05, 2011 at 04:15:34PM -0600, Stephen Warren wrote:
> > irq_to_gpio is deprecated and in the process of being removed. Make that
> > happen now for ARM Tegra.
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 
> Applied both.  Thanks.

Didn't you want an Ack by a Tegra maintainer first?

I assume they were both applied to gpio-next (although a fresh fetch  of that
doesn't show the commits)

> > I assume this will go into one of arm-soc.git's branches, but it depends
> > on the previous patch in this series to compile. Arnd, I see you already
> > have Grant's gpio/next tree in your repo as depends/gpio, so I assume
> > you'll just pick up and merge the latest version of Grant's tree before
> > applying this patch?
> >
> > Both patches compiled with a number of Tegra boards enable and tested on
> > Harmony. All without Device Tree support.
> >
> >  arch/arm/mach-tegra/include/mach/gpio.h |    8 --------
> >  1 files changed, 0 insertions(+), 8 deletions(-)

-- 
nvpublic
