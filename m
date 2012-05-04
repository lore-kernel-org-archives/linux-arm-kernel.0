From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 May 2012 12:49:10 -0700
Subject: [PATCH 4/7] ARM: OMAP2: Add MMC hwmod data for 2420
In-Reply-To: <alpine.DEB.2.00.1205021844280.19695@utopia.booyaka.com>
References: <20120424000607.17783.81686.stgit@muffinssi.local>
 <20120424000832.17783.21327.stgit@muffinssi.local>
 <alpine.DEB.2.00.1205021840160.19695@utopia.booyaka.com>
 <alpine.DEB.2.00.1205021844280.19695@utopia.booyaka.com>
Message-ID: <20120504194910.GS5613@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120502 18:05]:
> On Wed, 2 May 2012, Paul Walmsley wrote:
> 
> > Hi Tony,
> > 
> > On Mon, 23 Apr 2012, Tony Lindgren wrote:
> > 
> > > Add MMC for 2420 so we can pass the DMA request lines the same
> > > way as we already do on omap2430 and later.
> > > 
> > > Cc: Benoit Cousson <b-cousson@ti.com>
> > > Cc: Paul Walmsley <paul@pwsan.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Made a few changes here so that it applies on the omap-devel-a-for-3.5 tag 
> > that you pulled in.  Also changed the 2420 MMC class name to "msdi" and 
> > the hwmod name to "msdi1" -- this is the IP block name that is listed in 
> > the 2420 TRM Rev. X Table 26-9 "Instance Summary".  It also is convenient 
> > for us, because the 2420 MMC driver is different than the 2430+ HSMMC 
> > driver, so we can just probe all of the hwmods of class "msdi" to register 
> > the 2420 MMC :-)
> 
> Also, forgot to mention that a struct omap_hwmod_class_sysconfig record 
> was added here too, based on the info in the 2420 TRM.
> 
> The updated patch is below.  Have queued it in a hwmod data update branch 
> here along with some other hwmod data updates.  Will send a pull request 
> after testing is finished here...

OK

Tony 
