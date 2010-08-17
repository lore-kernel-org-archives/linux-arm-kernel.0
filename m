From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Aug 2010 09:57:32 +0100
Subject: warning: (CPU_V7 && !ARCH_OMAP2 || CPU_MMP2 && ARCH_MMP)
In-Reply-To: <008101cb3aaf$008009b0$01801d10$%kim@samsung.com>
References: <007f01cb3aaa$cc469460$64d3bd20$%kim@samsung.com>
	<20100813055939.GA12781@pengutronix.de>
	<008101cb3aaf$008009b0$01801d10$%kim@samsung.com>
Message-ID: <1282035452.406.3.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-08-13 at 07:15 +0100, Kukjin Kim wrote:
> Uwe Kleine-K?nig wrote:
> > On Fri, Aug 13, 2010 at 02:45:30PM +0900, Kukjin Kim wrote:
> > > I found build warning in the latest Linus' tree like following.
> > >
> > > warning: (CPU_V7 && !ARCH_OMAP2 || CPU_MMP2 && ARCH_MMP) selects CPU_32v6K
> > > which has unmet direct dependencies (CPU_V6)
> > 
> >       http://article.gmane.org/gmane.linux.ports.arm.kernel/84565
> >
> 
> There is no above 'warning' with Catalin's patch.
> 
> Is this going to Linus' tree in this merge window?

I'll post it to the list and Russell's patch system and it should
hopefully go in 2.6.36. The kbuild feature that shows such warnings only
appeared in 2.6.36-rc1.

-- 
Catalin
