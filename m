From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 13 Aug 2010 07:59:39 +0200
Subject: warning: (CPU_V7 && !ARCH_OMAP2 || CPU_MMP2 && ARCH_MMP)
In-Reply-To: <007f01cb3aaa$cc469460$64d3bd20$%kim@samsung.com>
References: <007f01cb3aaa$cc469460$64d3bd20$%kim@samsung.com>
Message-ID: <20100813055939.GA12781@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Aug 13, 2010 at 02:45:30PM +0900, Kukjin Kim wrote:
> Hi all,
> 
> I found build warning in the latest Linus' tree like following.
> 
> warning: (CPU_V7 && !ARCH_OMAP2 || CPU_MMP2 && ARCH_MMP) selects CPU_32v6K
> which has unmet direct dependencies (CPU_V6)
> 
> Thanks.
Can you try out

	http://article.gmane.org/gmane.linux.ports.arm.kernel/84565

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
