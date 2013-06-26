From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Jun 2013 20:17:04 +0200
Subject: [PATCH V10 1/4] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <007e01ce7153$4d4b0730$e7e11590$%kim@samsung.com>
References: <003a01ce6e50$6d5418b0$47fc4a10$@samsung.com>
 <20130625021102.GA13310@google.com>
 <007e01ce7153$4d4b0730$e7e11590$%kim@samsung.com>
Message-ID: <201306262017.04689.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 June 2013, Kukjin Kim wrote:
> Bjorn Helgaas wrote:
> > 
> > On Fri, Jun 21, 2013 at 04:24:54PM +0900, Jingoo Han wrote:
> > > Exynos5440 has a PCIe controller which can be used as Root Complex.
> > > This driver supports a PCIe controller as Root Complex mode.
> > >
> > > Signed-off-by: Surendranath Gurivireddy Balla <suren.reddy@samsung.com>
> > > Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> > > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Please merge this through arm-soc as you discussed.
> > 
> Sounds great.
> 
> Arnd, please take this series into arm-soc tree directly by yourself with my
> ack on arch/exynos stuff if you want ;)
> 

Ok, done.

I've put this on top of the next/soc tree, which already contains the
other PCI host controller support.

	Arnd
