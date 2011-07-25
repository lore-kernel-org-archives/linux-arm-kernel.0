From: vkoul@infradead.org (Vinod Koul)
Date: Mon, 25 Jul 2011 16:39:24 +0530
Subject: [RESEND] [PATCH V4 0/14] To use DMA generic APIs for Samsung DMA
In-Reply-To: <1311589020.27357.1.camel@vkoul-mobl4>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311589020.27357.1.camel@vkoul-mobl4>
Message-ID: <1311592164.29703.9.camel@vkoul-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-07-25 at 15:47 +0530, Vinod Koul wrote:
> On Mon, 2011-07-25 at 10:28 +0900, Boojin Kim wrote:
> > This patchset adds support DMA generic APIs for Samsung DMA
> > and is re-sent by the request of DMA maintainer, Vinod Koul.
> > 
> > V4 has the changes about 3 patches from V3.
> > Changes from V3:
> > - Divided '[03/13 patch] DMA: PL330: Add DMA capabilites' on V3 patchset
> >   into two patches.
> > 	- One is '03/14 patch' for supporting DMA_SLAVE_CONFIG command.
> > 	- Another is '04/14 patch' for supporting DMA_CYCLIC capability.
> > - Code clean-up
> > 	- Remove unnecessary vairable referance on '01/14 patch'.
> > 	- Remove redunancy code on '06/14 patch'
> > 
> > [PATCH V4 01/14] DMA: PL330: Add support runtime PM for PL330 DMAC
> > [PATCH V4 02/14] DMA: PL330: Update PL330 DMA API driver
> > [PATCH V4 03/14] DMA: PL330: Support DMA_SLAVE_CONFIG command
> > [PATCH V4 04/14] DMA: PL330: Add DMA_CYCLIC capability
> > [PATCH V4 05/14] ARM: SAMSUNG: Update to use PL330-DMA driver
> > [PATCH V4 06/14] ARM: SAMSUNG: Add common DMA operations
> > [PATCH V4 07/14] ARM: EXYNOS4: Use generic DMA PL330 driver
> > [PATCH V4 08/14] ARM: S5PV210: Use generic DMA PL330 driver
> > [PATCH V4 09/14] ARM: S5PC100: Use generic DMA PL330 driver
> > [PATCH V4 10/14] ARM: S5P64X0: Use generic DMA PL330 driver
> > [PATCH V4 11/14] ARM: SAMSUNG: Remove S3C-PL330-DMA driver
> > [PATCH V4 12/14] spi/s3c64xx: Add support DMA engine API
> > [PATCH V4 13/14] ASoC: Samsung: Update DMA interface
> > [PATCH V4 14/14] ARM: SAMSUNG: Remove Samsung specific enum type for dma direction
> > 
> Thanks for resending I will review them now, You should use git
> --cover-letter to generate this
> 
Also I noticed the whole patch set doesn't have any acks from previous
posting. If a patch has got ack from someone and it is not changed at
all in next posting then you can carry that ack.
Makes things easier for me to track while applying

-- 
~Vinod Koul
Intel Corp.
