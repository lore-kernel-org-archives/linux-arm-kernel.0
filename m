From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 9 Dec 2015 09:19:15 +0200
Subject: [PATCH 0/6] ARM: DTS: da850: eDMA new bindings and MMC/SPI DMA
 support
In-Reply-To: <1449237210-16381-1-git-send-email-peter.ujfalusi@ti.com>
References: <1449237210-16381-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <5667D5F3.80503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar,

On 12/04/2015 03:53 PM, Peter Ujfalusi wrote:
> Hi,
> 
> Switch to use the new eDMA bindings and enable DMA for MMC0, SPI1.
> Add node for MMC1.

Can you hold on this one for a bit since the eDMA bindings might change still.

> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (6):
>   ARM: DTS: da850: fix edma0 reg space
>   ARM: DTS: da850: Use the new DT bindings for the eDMA3
>   ARM: DTS: da850: Enable eDMA1
>   ARM: DTS: da850: Enable DMA use for MMC0
>   ARM: DTS: da850: Add node for mmc1
>   ARM: DTS: da850: Enable DMA for SPI1
> 
>  arch/arm/boot/dts/da850-enbw-cmc.dts |  9 ++++++
>  arch/arm/boot/dts/da850-evm.dts      |  9 ++++++
>  arch/arm/boot/dts/da850.dtsi         | 59 ++++++++++++++++++++++++++++++++----
>  3 files changed, 71 insertions(+), 6 deletions(-)
> 


-- 
P?ter
