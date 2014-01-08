From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Jan 2014 15:40:48 -0800
Subject: [PATCH 0/3] omap2: Assorted GPMC cleanups
In-Reply-To: <20140108233815.GC2595@localhost>
References: <1382921508-5104-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140108191836.GD31323@atomide.com>
 <20140108233815.GC2595@localhost>
Message-ID: <20140108234048.GH31323@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ezequiel Garcia <ezequiel.garcia@free-electrons.com> [140108 15:39]:
> On Wed, Jan 08, 2014 at 11:18:37AM -0800, Tony Lindgren wrote:
> > * Ezequiel Garcia <ezequiel.garcia@free-electrons.com> [131027 17:52]:
> > > (I'm CCing the MTD list, because GPMC is the memory controller
> > > used for NOR, NAND and OneNAND devices).
> > > 
> > > Hi all,
> > > 
> > > Just a small patchset containing two small cleanups and a minor fix
> > > for the GPMC memory controller. The first two are cleanups and can
> > > be considered as preparation work for the fix.
> > > 
> > > The fix is patch 3/3: "Move legacy GPMC width setting". It makes
> > > explicit use of the DT property "gpmc,device-width" and removes the
> > > subsequent (and redundant) setting of the GPMC width, based in the
> > > NAND bus widht.
> > 
> > Thanks and sorry for the delay. Applying these all into branch
> > omap-for-v3.14/fixes-not-urgent.
> > 
> 
> No problem. I'll give this a test/review next week.
> 
> Do we still need the board-file (legacy) workaround in this patchset?
> I was actually waiting for you to clean-up completely that, before
> re-sending the series, without the board-file workaround.

Yes we still need it for a little bit longer.

Regards,

Tony
