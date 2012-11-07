From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Nov 2012 17:58:42 -0800
Subject: [GIT PULL] ARM: OMAP: second set of PRCM cleanups for 3.8
In-Reply-To: <alpine.DEB.2.00.1211070150100.8758@utopia.booyaka.com>
References: <alpine.DEB.2.00.1211011216130.26661@utopia.booyaka.com>
 <20121106220833.GQ6801@atomide.com>
 <alpine.DEB.2.00.1211070150100.8758@utopia.booyaka.com>
Message-ID: <20121107015841.GC6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121106 17:54]:
> On Tue, 6 Nov 2012, Tony Lindgren wrote:
> 
> > ..now wondering which configs do not build for you at 7fc54fd3?
> > 
> > It builds at least all my test configs. Well at least the ones
> > I have recovered after accidentally deleting some files yesterday,
> > did not have a back up copy of two of them.

The build errors you are talking about are the ones I already pulled
into one of the cleanup branches, right? If so, that's fine.
 
> > However if I pull your branch in, build breaks for me for
> > with the rmk-omap3430-ldp-noconfig and rmk-omap4430-sdp-noconfig:
> > 
> > arch/arm/mach-omap2/built-in.o:(.arch.info.init+0x48): undefined reference to `omap44xx_restart'
> 
> They all build successfully here.  Here are the rmk config results:
> 
> rmk-omap3430-ldp:
> http://www.pwsan.com/omap/testlogs/prcm_cleanup_b_3.8/20121101044824/build/rmk_omap3430_ldp_oldconfig/
> 
> rmk-omap4430-sdp:
> http://www.pwsan.com/omap/testlogs/prcm_cleanup_b_3.8/20121101044824/build/rmk_omap4430_sdp_oldconfig/
> 
> Maybe the versions of the rmk configs you're using are different than 
> mine?  The ones here were updated during the v3.6 -> v3.7-rc1 transition.
> You can find mine at:
> 
> http://www.pwsan.com/omap/testlogs/prcm_cleanup_b_3.8/20121101044824/build/rmk_omap3430_ldp_oldconfig/rmk_omap3430_ldp_oldconfig
> 
> http://www.pwsan.com/omap/testlogs/prcm_cleanup_b_3.8/20121101044824/build/rmk_omap4430_sdp_oldconfig/rmk_omap4430_sdp_oldconfig

I'm getting errors with the allnoconfig ones, there are total four
omap defconfigs there not counting the randconfigs.

Regards,

Tony
