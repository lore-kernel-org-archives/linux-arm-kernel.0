From: agross@codeaurora.org (Andy Gross)
Date: Tue, 13 May 2014 17:20:22 -0500
Subject: [PATCH 4/4] spi: qup: Add support for v1.1.1
In-Reply-To: <20140513220845.GH20486@codeaurora.org>
References: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
 <1400016884-9568-5-git-send-email-agross@codeaurora.org>
 <20140513220845.GH20486@codeaurora.org>
Message-ID: <20140513222022.GA28128@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 03:08:45PM -0700, Stephen Boyd wrote:
> On 05/13, Andy Gross wrote:
> > @@ -488,7 +491,7 @@ static int spi_qup_probe(struct platform_device *pdev)
> >  	struct resource *res;
> >  	struct device *dev;
> >  	void __iomem *base;
> > -	u32 data, max_freq, iomode;
> > +	u32 data = 0, max_freq, iomode;
> 
> It looks like data is unused? But actually it's used to print a
> version out and now it will always print version 0. Perhaps that
> printk needs an update?

ACK!  I thought I killed that.  I'll fix that.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
