From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Jul 2011 18:26:45 +0900
Subject: [PATCH 6/7] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <CABb+yY3UqrbBNS1J1X1gCxPLp8Kv8JSe92Pnb7JpE9x9kqTPiA@mail.gmail.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<201107041859.11548.heiko@sntech.de>
	<20110704170217.GH28042@ponder.secretlab.ca>
	<201107042151.44075.heiko@sntech.de>
	<20110704232758.GB12824@ponder.secretlab.ca>
	<00bd01cc3ae1$f1dbfac0$d593f040$%kim@samsung.com>
	<CABb+yY3UqrbBNS1J1X1gCxPLp8Kv8JSe92Pnb7JpE9x9kqTPiA@mail.gmail.com>
Message-ID: <001101cc3d51$29b40250$7d1c06f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> 
> > As you saw, the S3C_DMA_API is still used for PL080 DMA for compatibilities
> > with this patches in each driver, e.g., spi and audio. As a note, S3C24XX
> > and S3C64XX include PL080 DMAC not PL330.
> Not exactly.
> S3C24XX  use 2-3 different versions of Samsung's DMA implementations.
> S3C6400/10  use PL080
> S5P and later series use PL330

Your information is correct, I was confused.

> > Of course, if we can remove every S3C_DMA_API, that can be the best solution
> > but it needs more time. I'd like to go to our goal step by step.
> >
> Ideally, like PL330 for S5Pxxxx, drivers/dma/pl080 should be enabled for s3c64xx
> And new generic dma api drivers written for S3C24xx in drivers/dma/
> 
We're thinking about this :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
