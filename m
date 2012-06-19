From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Jun 2012 14:47:44 +0800
Subject: [PATCH 16/16] ARM: imx: enable SPARSE_IRQ for imx platform
In-Reply-To: <20120619061637.GB10387@shlinux2.ap.freescale.net>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-17-git-send-email-shawn.guo@linaro.org>
 <20120618084850.GG25447@shlinux2.ap.freescale.net>
 <20120618150422.GG19249@S2101-09.ap.freescale.net>
 <20120619061637.GB10387@shlinux2.ap.freescale.net>
Message-ID: <20120619064742.GE21951@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 02:16:38PM +0800, Dong Aisheng wrote:
> > > Ideally i would see we keep the code as before that still using hw irqs
> > > for device resource definition, but convert to linux virt irq in a standard
> > > irqdomain map way when adding devices by calling imx_add_platform_device.
> > > 
> > What's the point of hiding this irq number conversion in
> > imx_add_platform_device?  
> It's standard and safe way.
> 
Why do you think it's standard?  Care to show me a couple of examples
that make this conversion when adding platform device?

> > The irq number used in resource definition
> > should simply just be Linux irq.  Doing what you suggest here will
> No, it's should be hw irq.

You are simply wrong here.  Nothing more to respond on this.

-- 
Regards,
Shawn
