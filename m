From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Feb 2010 10:32:03 +0000
Subject: PL-330 DMA driver
In-Reply-To: <e9c3a7c21002172224y7a80d913r5b78c1e41a91565f@mail.gmail.com>
References: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
	<e9c3a7c21002172224y7a80d913r5b78c1e41a91565f@mail.gmail.com>
Message-ID: <20100218103203.GB20243@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2010 at 11:24:28PM -0700, Dan Williams wrote:
> On Tue, Feb 16, 2010 at 10:50 PM, jassi brar <jassisinghbrar@gmail.com> wrote:
> > Hello,
> >
> > ?Many Samsung SoCs have PL-330 as the DMA controller and the driver
> > is missing in the mainline.
> >
> > A few months ago, Joonyoung Shim of Samsung, attempted the driver for PL-330
> > based on the DMA API(drivers/dma/), but the patches weren't accepted.
> 
> Looking back at the archives seems I missed this patch.  So it was not
> rejected just overlooked.  Do we want to move forward on that patch as
> it stands, or go a different direction?  If it is resubmitted I will
> get it in the queue for 2.6.34.

If it's a generic ARM primecell, it's likely it will be used elsewhere as
well (primecells are gaining popularity at the moment.)  Having it not
be specific to S3C would be a big advantage, unless of course everyone
specifically wants to have divergent copies of the same code.
