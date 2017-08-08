From: rogerq@ti.com (Roger Quadros)
Date: Tue, 8 Aug 2017 13:02:39 +0300
Subject: [PATCH 0/3] ARM: dts: am335x-evm: am437xx: dra7xx: Enable NAND
 DMA prefetch by default
In-Reply-To: <20170726021552.19880-1-fcooper@ti.com>
References: <20170726021552.19880-1-fcooper@ti.com>
Message-ID: <2fd38d80-16ce-8548-0f8a-38eaf820f87e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/17 05:15, Franklin S Cooper Jr wrote:
> Enable NAND DMA prefetch by default for AM335x, AM437x and DRA7x evms that
> include NAND.
> 
> The below commit went into additional details regarding performance numbers
> seen between the two modes.
> 
> commit aa7abd312c11 ("mtd: nand: omap2: Support parsing dma channel information from DT")
> 
> Franklin S Cooper Jr (3):
>   ARM: dts: am335x-evm: Enable NAND dma prefetch by default
>   ARM: dts: am437xx: Enable NAND dma prefetch by default
>   ARM: dts: dra7xx: Enable NAND dma prefetch by default

For all patches,

Acked-by: Roger Quadros <rogerq@ti.com>

> 
>  arch/arm/boot/dts/am335x-evm.dts        | 1 +
>  arch/arm/boot/dts/am437x-gp-evm.dts     | 1 +
>  arch/arm/boot/dts/am43x-epos-evm.dts    | 1 +
>  arch/arm/boot/dts/dra7-evm.dts          | 1 +
>  arch/arm/boot/dts/dra72-evm-common.dtsi | 1 +
>  5 files changed, 5 insertions(+)
> 

-- 
cheers,
-roger
