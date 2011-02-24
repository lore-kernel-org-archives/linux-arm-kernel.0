From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 Feb 2011 01:18:27 -0700 (MST)
Subject: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
	hwmod right before timer init
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037A095471@dbde02.ent.ti.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
	<20110223071153.5874.58923.stgit@twilight.localdomain>
	<5A47E75E594F054BAF48C5E4FC4B92AB037A095471@dbde02.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1102240115300.6198@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tarun

On Wed, 23 Feb 2011, DebBarma, Tarun Kanti wrote:

> > -----Original Message-----
> > From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> > owner at vger.kernel.org] On Behalf Of Paul Walmsley
> > Sent: Wednesday, February 23, 2011 12:42 PM
> > To: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> > Cc: Tony Lindgren; Hilman, Kevin; Shilimkar, Santosh; Cousson, Benoit
> > Subject: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
> > hwmod right before timer init
> I am not able to apply this patch.
> Patch 1-7 applied successfully on top of:
> 04aa67d  Merge branch 'for-tony' of git://gitorious.org/usb/usb into omap-for-linus

Thanks, it seems that there was a stray header change left in my original 
tree.  The updated version is here:

   http://marc.info/?l=linux-omap&m=129853532211359&w=2


- Paul
