From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 13 Aug 2010 15:15:32 +0900
Subject: warning: (CPU_V7 && !ARCH_OMAP2 || CPU_MMP2 && ARCH_MMP)
In-Reply-To: <20100813055939.GA12781@pengutronix.de>
References: <007f01cb3aaa$cc469460$64d3bd20$%kim@samsung.com>
	<20100813055939.GA12781@pengutronix.de>
Message-ID: <008101cb3aaf$008009b0$01801d10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:
> 
> Hello,
> 
Hi :-)

> On Fri, Aug 13, 2010 at 02:45:30PM +0900, Kukjin Kim wrote:
> > Hi all,
> >
> > I found build warning in the latest Linus' tree like following.
> >
> > warning: (CPU_V7 && !ARCH_OMAP2 || CPU_MMP2 && ARCH_MMP) selects
> CPU_32v6K
> > which has unmet direct dependencies (CPU_V6)
> >
> > Thanks.
> Can you try out
> 
Oh, yes...Sure ;-)

> 	http://article.gmane.org/gmane.linux.ports.arm.kernel/84565
> 

There is no above 'warning' with Catalin's patch.

Is this going to Linus' tree in this merge window?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
