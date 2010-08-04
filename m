From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 Aug 2010 08:51:24 +0300
Subject: [GIT PULL] OMAP: clock, hwmod, omap_device, PM constraints:
	patches for 2.6.36
In-Reply-To: <877hk7nxfx.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1007031548010.16344@utopia.booyaka.com>
	<20100706110918.GJ3192@atomide.com>
	<877hk7nxfx.fsf@deeprootsystems.com>
Message-ID: <20100804055123.GD6840@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [100804 01:21]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Paul Walmsley <paul@pwsan.com> [100704 00:43]:
> >> 
> >> Hi Tony,
> >> 
> >> here's the pull request for some clock, hwmod, omap_device, PM constraints 
> >> patches for 2.6.36.
> >
> > Thanks, pulled into omap-for-linus.
> >
> 
> Hmm, I don't see this in current omap-for-linus.  Is it still planned
> for 2.6.36?  

Thanks for checking. Paul asked me to redo the pull after fixing some
credits, and looks like then I forgot to pull.
 
> Once this is merged, the all the hwmod/omap_device conversions will only
> have a dependency on the OMAP runtime PM core.

Yeah that's good!

Tony
