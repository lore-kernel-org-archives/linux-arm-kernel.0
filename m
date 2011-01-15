From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 14 Jan 2011 16:14:50 -0800
Subject: [PATCH] dmaengine: at_hdmac: use dma_address to program DMA
	hardware
In-Reply-To: <4D2B07D0.5050602@atmel.com>
References: <1292435416-16927-1-git-send-email-nicolas.ferre@atmel.com>
	<4D2B07D0.5050602@atmel.com>
Message-ID: <AANLkTi=80SM+SVF=ZVW4M+QOOohzPrwjvmudMWdHVo3D@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 5:21 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Le 15/12/2010 18:50, Nicolas Ferre :
>> In atc_prep_slave_sg() function we use dma_address field of scatterlist with
>> sg_dma_address() macro instead of sg_phys(). DMA address is already computed
>> by dma_map_sg() or another mapping function in calling driver.
>
> Ping?
>

Applied.
