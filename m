From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 11 May 2012 07:01:19 +0000
Subject: [PATCH-V2 2/4] ARM: OMAP2+: CLEANUP: Move omap3 dpll ops to
 dpll3xxx.c
In-Reply-To: <alpine.DEB.2.00.1205101701420.32719@utopia.booyaka.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
 <1336506724-5494-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1205101701420.32719@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA221FF@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 04:32:11, Paul Walmsley wrote:
> On Wed, 9 May 2012, Vaibhav Hiremath wrote:
> 
> > In order to remove unnecessary idefs, move noncore and core
> > dpll ops to dpll3xxx.c file (where it should have been already).
> > 
> > The clkops (clkops_omap3_core_dpll_ops & clkops_omap3_noncore_dpll_ops)
> > is used in clock data files, and dependency is already handled by
> > Makefile rule.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> 
> This is probably okay.
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> 

Thanks Paul,

Thanks,
Vaibhav
