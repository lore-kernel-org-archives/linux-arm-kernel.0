From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Wed, 16 Jun 2010 14:08:44 +0300
Subject: [PATCH 0/4]Refine iomux files for i.MX51
In-Reply-To: <20100616064723.GH20799@pengutronix.de>
References: <1276352559-8105-1-git-send-email-jason77.wang@gmail.com>
	<20100616064723.GH20799@pengutronix.de>
Message-ID: <20100616110844.GC3210@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Jun 16, Sascha Hauer wrote:
> On Sat, Jun 12, 2010 at 10:22:35PM +0800, Jason Wang wrote:
> > Through the discussion, I divide my patches to 3 parts.
> > part1: mx51 iomux related part, the first patch in this part is from
> >        Amit, other patches are based off this patch and they are some
> >        fix or adding definitions for imx51_3ds board.
> 
> This is ok now. Can you please rebase onto
> git://git.pengutronix.de/git/imx/linux-2.6.git imx-for-2.6.36
> 
> The first patch conflicts with another of your patches:
> 
> e5ceef78 mx5: Add i2c to Freescale MX51 Babbage HW
> 

Please find rebased patch below.

It is only compile-tested (broken board getting updated)

Cheers,
Amit
-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
