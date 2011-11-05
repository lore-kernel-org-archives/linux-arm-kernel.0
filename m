From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Nov 2011 17:39:06 -0700
Subject: [GIT PULL] ARM: OMAP3+: clock fixes for 3.2
In-Reply-To: <alpine.DEB.2.00.1110070154100.4611@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110070141450.4611@utopia.booyaka.com>
	<alpine.DEB.2.00.1110070154100.4611@utopia.booyaka.com>
Message-ID: <20111105003906.GN31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111007 00:20]:
> On Fri, 7 Oct 2011, Paul Walmsley wrote:
> 
> > The following changes since commit be73246058737beec52ae232bcab7776332a9e06:
> > 
> >   ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)
> > 
> > are available in the git repository at:
> >   git://git.pwsan.com/linux-2.6 omap_clock_fixes_3.2
> > 
> > Jon Hunter (3):
> >       ARM: OMAP3+: dpll: use DPLLs recalc function instead of omap2_get_dpll_rate
> >       ARM: OMAP4: clock: Add missing clock divider for OCP_ABE_ICLK
> >       OMAP3+: Update DPLL Fint range for OMAP36xx and OMAP4xxx devices
> 
> By the way, the subject line for this patch has been updated in the git 
> branch to be prefixed with "ARM: ".

Thanks pulling into fixes.

Tony
