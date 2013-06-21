From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Jun 2013 10:11:44 -0400
Subject: [PATCH V10 0/4] PCIe support for Samsung Exynos5440 SoC
In-Reply-To: <201306211030.47440.arnd@arndb.de>
References: <003901ce6e50$03d039a0$0b70ace0$@samsung.com>
 <201306210931.58428.arnd@arndb.de> <20130621094723.312bc331@skate>
 <201306211030.47440.arnd@arndb.de>
Message-ID: <20130621141144.GP31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 10:30:47AM +0200, Arnd Bergmann wrote:
> On Friday 21 June 2013, Thomas Petazzoni wrote:
> > I am by far not an expert on how to solve merge strategies and so on,
> > but to avoid conflicts at Linus's level while merging the arm-soc and
> > pci trees, it would be better if this Samsung PCIe driver could go
> > through arm-soc (with Bjorn ACK, of course), so that Arnd/Olof can
> > make sure the ordering is correct with regard to the of/pci changes and
> > the mvebu/pci driver.
> 
> Yes, good point.
> 
> The alternative would be that Bjorn also takes the PCI branch dependencies
> that are already in arm-soc into his tree. Either way works, but I agree
> that what you suggest would be simpler.

Yes, that is why we did it this way.  It was my understanding based on
previous comments by yourself and LinusW that you both had patches
depending on (now called) mvebu/of_pci.  So we got it into arm-soc
early so those branches could depend on it.

hth,

Jason.
