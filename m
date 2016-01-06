From: tony@atomide.com (Tony Lindgren)
Date: Wed, 6 Jan 2016 09:47:13 -0800
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <20160106174039.GA14271@earth>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
 <201601041834.56056@pali> <20160104174001.GD12777@atomide.com>
 <568AC0F9.2010304@gmail.com> <20160105041356.GE12777@atomide.com>
 <20160105084947.GG22661@pali> <20160105224929.GF12777@atomide.com>
 <20160106174039.GA14271@earth>
Message-ID: <20160106174713.GL12777@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@kernel.org> [160106 09:41]:
> Hi,
> 
> On Tue, Jan 05, 2016 at 02:49:29PM -0800, Tony Lindgren wrote:
> > Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug")
> > unified the GPMC debug for the SoCs with GPMC. The commit also left
> > out the option for HWMOD_INIT_NO_RESET as we now require proper timings
> > for GPMC to be able to remap GPMC devices out of address 0.
> > 
> > Unfortunately on 900, onenand now only partially works with the device
> 
> You may want to change 900 to n900 (maybe even Nokia N900) before
> actually committing this.

Thanks will do.

Tony
