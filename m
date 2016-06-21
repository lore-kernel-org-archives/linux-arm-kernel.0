From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Jun 2016 04:25:36 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: Drop legacy board file for n900
In-Reply-To: <20160615120556.GZ22406@atomide.com>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <1465987689-14812-2-git-send-email-tony@atomide.com>
 <20160615105552.GN29844@pali> <20160615110201.GY22406@atomide.com>
 <20160615114936.GO29844@pali> <20160615120556.GZ22406@atomide.com>
Message-ID: <20160621112535.GN22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160615 05:08]:
> * Pali Roh?r <pali.rohar@gmail.com> [160615 04:52]:
> > On Wednesday 15 June 2016 04:02:02 Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * Pali Roh?r <pali.rohar@gmail.com> [160615 03:58]:
> > > > Hi! I just quickly looked at N900 status matrix https://elinux.org/N900
> > > > and there is still one thing not finished in DT: It is slot-name for
> > > > omap_hsmmc driver. So switch from legacy board code to DT is regression.
> > > 
> > > That's fixed with the following in v4.7-rc series:
> > > 
> > > db863d896681 ("mmc: omap_hsmmc: Check if MMC slot name is passed in pdata")
> > > 10c1f7d32bf4 ("ARM: OMAP2+: n900 needs MMC slot names for legacy user space")
> > 
> > Great! Sorry, but now wiki is not fully updated with last changes and I
> > do not have in my mind what was finished/merged and what not. It is
> > going hard for me to track everything.
> 
> OK well maybe take one more look and then ack if no more issues.

Pali, any news on this?

Regards,

Tony
