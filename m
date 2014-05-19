From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 19 May 2014 15:13:06 +0800
Subject: [PATCH 1/4] ARM: imx: move SOC_IMX5 and SOC_IMX51 into 'Device
 tree only'
In-Reply-To: <1400483195.557817536@f437.i.mail.ru>
References: <1400482606-8278-1-git-send-email-shawn.guo@freescale.com>
 <1400482606-8278-2-git-send-email-shawn.guo@freescale.com>
 <1400483195.557817536@f437.i.mail.ru>
Message-ID: <20140519071304.GL10685@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 11:06:35AM +0400, Alexander Shiyan wrote:
> > @@ -704,6 +691,19 @@ if ARCH_MULTI_V7
> >  
> >  comment "Device tree only"
> >  
> > +config SOC_IMX5
> > +	bool
> > +	select ARCH_HAS_CPUFREQ
> > +	select ARCH_HAS_OPP
> > +	select ARCH_MXC_IOMUX_V3
> 
> We can drop ARCH_MXC_IOMUX_V3 now.

Yes, you're right.  Dropped it.  Thanks, Alexander.

Shawn
