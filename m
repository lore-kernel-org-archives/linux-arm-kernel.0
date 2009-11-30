From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 30 Nov 2009 01:36:04 +0100
Subject: [PATCH v4 0/6] ARM:  ST-Ericsson's U8500 SMP platform, a new
	patch set
In-Reply-To: <20091128102246.GB25671@n2100.arm.linux.org.uk>
References: <1259279725.13327.65.camel@vinay-desktop>
	<20091127194950.GA28193@n2100.arm.linux.org.uk>
	<20091128102246.GB25671@n2100.arm.linux.org.uk>
Message-ID: <20091130003604.GC18841@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:22 Sat 28 Nov     , Russell King - ARM Linux wrote:
> On Fri, Nov 27, 2009 at 07:49:50PM +0000, Russell King - ARM Linux wrote:
> > On Fri, Nov 27, 2009 at 05:25:25AM +0530, srinidhi kasagar wrote:
> > > From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > > Date: Fri, 27 Nov 2009 16:24:37 +0530
> > > 
> > > This is the v4 version of patch set which adds U8500 machine.
> > > v3 patch was posted to this list on 12th October 2009 and I 
> > > have addressed the comments from Jean christophe on this version. 
> > > 
> > > The patch series has a dependency on the patch 5786/1 available in
> > > Russell's patch tracking system. 5786/1 must be applied first.
> > 
> > This looks fine - unless anyone has any objections, I'd suggest submitting
> > to the patch system since it depends on this currently unmerged patch.
> 
> One last thing - please also provide a patch for the top level MAINTAINERS
> file for this.
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

a config HAS_SMP will good to introduce to avoid this long list

config SMP
	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
		MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || ARCH_U8500)

Best Regards,
J.
