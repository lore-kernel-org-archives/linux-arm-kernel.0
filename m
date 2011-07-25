From: boojin.kim@samsung.com (Boojin Kim)
Date: Mon, 25 Jul 2011 19:34:32 +0900
Subject: [PATCH V4 12/14] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <20110725094002.GD9653@n2100.arm.linux.org.uk>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-13-git-send-email-boojin.kim@samsung.com>
	<20110725094002.GD9653@n2100.arm.linux.org.uk>
Message-ID: <002101cc4ab6$70fa0ac0$52ee2040$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux Wrote:

> Sent: Monday, July 25, 2011 6:40 PM
> To: Boojin Kim
> Cc: linux-arm-kernel at lists.infradead.org;
linux-samsung-soc at vger.kernel.org;
> Kukjin Kim; Vinod Koul; Jassi Brar; Grant Likely; Mark Brown; Dan Williams
> Subject: Re: [PATCH V4 12/14] spi/s3c64xx: Add support DMA engine API
>
> On Mon, Jul 25, 2011 at 10:28:30AM +0900, Boojin Kim wrote:
> > +static void s3c64xx_spi_dma_rxcb(void *data)
> > +{
> > +	struct s3c64xx_spi_driver_data *sdd
> > +		= (struct s3c64xx_spi_driver_data *)data;
>
> You never need explicit casts from void * or to void *.  Please remove
> these.
I will address your comment.
