From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Sep 2011 20:29:59 +0900
Subject: [PATCH v8 00/16] To use DMA generic APIs for Samsung DMA
In-Reply-To: <1315980099.26251.498.camel@vkoul-udesk3>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
	<1315980099.26251.498.camel@vkoul-udesk3>
Message-ID: <007601cc72d1$a3356aa0$e9a03fe0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul wrote:
> 
> On Fri, 2011-09-02 at 09:44 +0900, Boojin Kim wrote:
> > This patchset adds support DMA generic APIs for samsung DMA.
> >
> > The changes from V7 is following:
> > - Divides patch file.
> >   : The 03 patch on V7 patchset is divided into the 03 and 04 patch on V8
> patchset.
> >     The O3 patch is only for DMA_SLAVE_CONFIG command.
> >     The 04 patch is only for DMA_TERMINATE_ALL command.
> > - Code clean-up
> >   : Remove unnecessary code on 05 patch.
> >
> > [PATCH v8 01/16] DMA: PL330: Add support runtime PM for PL330 DMAC
> > [PATCH v8 02/16] DMA: PL330: Update PL330 DMA API driver
> > [PATCH v8 03/16] DMA: PL330: Support DMA_SLAVE_CONFIG command
> > [PATCH v8 04/16] DMA: PL330: Remove the start operation for handling
> DMA_TERMINATE_ALL command
> > [PATCH v8 05/16] DMA: PL330: Add DMA_CYCLIC capability
> > [PATCH v8 06/16] ARM: SAMSUNG: Update to use PL330-DMA driver
> > [PATCH v8 07/16] ARM: SAMSUNG: Add common DMA operations
> > [PATCH v8 08/16] ARM: EXYNOS4: Use generic DMA PL330 driver
> > [PATCH v8 09/16] ARM: S5PV210: Use generic DMA PL330 driver
> > [PATCH v8 10/16] ARM: S5PC100: Use generic DMA PL330 driver
> > [PATCH v8 11/16] ARM: S5P64X0: Use generic DMA PL330 driver
> > [PATCH v8 12/16] ARM: SAMSUNG: Remove S3C-PL330-DMA driver
> > [PATCH v8 13/16] spi/s3c64xx: Add support DMA engine API
> > [PATCH v8 14/16] spi/s3c64xx: Merge dma control code
> > [PATCH v8 15/16] ASoC: Samsung: Update DMA interface
> > [PATCH v8 16/16] ARM: SAMSUNG: Remove Samsung specific enum type for
> dma direction
> Thanks,
> 
> I have pushed these into my samsung-dma branch, Fixed the typos in the
> changelog of patch 4.
> 
> Please check and let me know if all are fine, I will push them to my
> next tomorrow
> 
Hi Vinod,

Thanks for your applying.

When you push them to your next, I will merge samsung-dma branch to my -next to avoid conflicts.

If any problems, please let me know.

> If anyone has concerns on this series please let me know by tomorrow

Thanks again.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
