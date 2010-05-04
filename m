From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Tue, 04 May 2010 10:26:03 +0300
Subject: [PATCH 11/11] omap2/3/4: Disable CONFIG_FB_OMAP in omap3_defconfig
In-Reply-To: <20100504005222.GD29604@atomide.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
	<20100430203411.25812.30019.stgit@baageli.muru.com>
	<20100430205003.GG29604@atomide.com>
	<20100504005222.GD29604@atomide.com>
Message-ID: <1272957963.1978.25.camel@tubuntu.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2010-05-04 at 02:52 +0200, ext Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [100430 13:47]:
> > * Tony Lindgren <tony@atomide.com> [100430 13:32]:
> > > Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
> > > at least on zoom3 for multi-omap. Disable CONFIG_FB until the
> > > omap FB code is fixed.
> > 
> > This one I'll drop as soon as the problem is sorted out with
> > CONFIG_FB_OMAP.
> 
> This one seems to be something under drivers/video/omap, so
> I'll change CONFIG_FB_OMAP to be a module now. Updated patch
> below.
> 
> I'll update omap for-next accordingly, then Tomi can figure
> it out :)

This sounds... interesting... =) Any more info on what happens? Does it
also affect new omapfb driver?

 Tomi
