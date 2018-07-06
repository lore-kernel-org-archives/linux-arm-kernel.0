From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 6 Jul 2018 13:21:46 +0100
Subject: [PATCH 1/2] PCI: aardvark: Size bridges before resources
 allocation
In-Reply-To: <20180706134245.3a554b27@windsurf>
References: <20180629091620.31503-1-thomas.petazzoni@bootlin.com>
 <20180629091620.31503-2-thomas.petazzoni@bootlin.com>
 <20180705141522.GA13716@red-moon>
 <20180705161909.2a7a6030@windsurf>
 <20180706110130.GA14439@red-moon>
 <20180706134245.3a554b27@windsurf>
Message-ID: <20180706122146.GA14795@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 01:42:45PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 6 Jul 2018 12:01:30 +0100, Lorenzo Pieralisi wrote:
> 
> > > It is a serious bug, but it is not a regression. I.e whatever is fixed
> > > by this patch never worked. So if you take a conservative view on
> > > pushing patches to stable and only want to fix regressions, this one
> > > doesn't qualify. However, if you take a more open approach and say you
> > > want to fix obvious bugs/issues even in older stable kernels, then
> > > indeed this patch qualifies.
> > > 
> > > If you are within the kernel developers with this more open approach to
> > > sending patches to stable, then you can add:
> > > 
> > > Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
> > > Cc: <stable@vger.kernel.org>
> > > 
> > > when applying the patch. Unless of course you want me to resend the
> > > patch series with this added. Just let met know what you prefer.  
> > 
> > It is up to you, I think it qualifies for stable kernels so I would
> > send it but it is your choice, please let me know.
> 
> It's OK for me to have it in stable kernels. The fix is pretty obvious,
> so you can add the Fixes/Cc tags when applying. Unless of course you
> want me to resend an updated version.

Applied to pci/aardvark for v4.19, thanks.

Lorenzo
