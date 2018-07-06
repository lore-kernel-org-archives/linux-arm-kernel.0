From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 6 Jul 2018 12:01:30 +0100
Subject: [PATCH 1/2] PCI: aardvark: Size bridges before resources
 allocation
In-Reply-To: <20180705161909.2a7a6030@windsurf>
References: <20180629091620.31503-1-thomas.petazzoni@bootlin.com>
 <20180629091620.31503-2-thomas.petazzoni@bootlin.com>
 <20180705141522.GA13716@red-moon>
 <20180705161909.2a7a6030@windsurf>
Message-ID: <20180706110130.GA14439@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2018 at 04:19:09PM +0200, Thomas Petazzoni wrote:
> Hello Lorenzo,
> 
> Thanks for your feedback!
> 
> On Thu, 5 Jul 2018 15:15:22 +0100, Lorenzo Pieralisi wrote:
> 
> > I am queueing these two patches but this one seems a serious bug,
> > I reckon we should send it to stable kernels (and would be grateful
> > if you provide me with a Fixes tag and a kernel log to add to the
> > commit log).
> 
> It is a serious bug, but it is not a regression. I.e whatever is fixed
> by this patch never worked. So if you take a conservative view on
> pushing patches to stable and only want to fix regressions, this one
> doesn't qualify. However, if you take a more open approach and say you
> want to fix obvious bugs/issues even in older stable kernels, then
> indeed this patch qualifies.
> 
> If you are within the kernel developers with this more open approach to
> sending patches to stable, then you can add:
> 
> Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
> Cc: <stable@vger.kernel.org>
> 
> when applying the patch. Unless of course you want me to resend the
> patch series with this added. Just let met know what you prefer.

It is up to you, I think it qualifies for stable kernels so I would
send it but it is your choice, please let me know.

Thanks,
Lorenzo

> Thanks!
> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
