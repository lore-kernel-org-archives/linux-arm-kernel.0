From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 14:30:17 -0700
Subject: [PATCH v2 1/5] [media] omap3isp: Fix compilation error in ispreg.h
In-Reply-To: <20121007101718.073aed3b@infradead.org>
References: <20120927195526.GP4840@atomide.com>
 <1349131591-10804-1-git-send-email-ido@wizery.com>
 <20121002163158.GR4840@atomide.com>
 <20121007101718.073aed3b@infradead.org>
Message-ID: <20121008213016.GO13011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mauro Carvalho Chehab <mchehab@infradead.org> [121007 06:18]:
> Em Tue, 2 Oct 2012 09:31:58 -0700
> Tony Lindgren <tony@atomide.com> escreveu:
> 
> > * Ido Yariv <ido@wizery.com> [121001 15:48]:
> > > Commit c49f34bc ("ARM: OMAP2+ Move SoC specific headers to be local to
> > > mach-omap2") moved omap34xx.h to mach-omap2. This broke omap3isp, as it
> > > includes omap34xx.h.
> > > 
> > > Instead of moving omap34xx to platform_data, simply add the two
> > > definitions the driver needs and remove the include altogether.
> > > 
> > > Signed-off-by: Ido Yariv <ido@wizery.com>
> > 
> > I'm assuming that Mauro picks this one up, sorry
> > for breaking it.
> 
> Picked, thanks. 
> 
> With regards to the other patches in this series, IMHO, it
> makes more sense to go through arm omap tree, so, for the
> patches on this series that touch at drivers/media/platform/*:
> 
> Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>

Thanks yeah it's best that I pick up the rest. I can setup
a minimal branch that can also be pulled into iommu branch
after -rc1.

Regards,

Tony
