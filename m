From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu, 18 Nov 2010 08:51:48 +0100
Subject: [PATCH] arm: ixp4xx export symbol dma_set_coherent_mask
In-Reply-To: <201011172325.10894.brian@walsh.ws>
References: <201011172325.10894.brian@walsh.ws>
Message-ID: <op.vmcv4jpf2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Nov 2010 05:25:10 +0100, Brian Walsh <brian@walsh.ws> wrote:

> ARM ixp4xx module building has been broken since commit 710224fa2750.
> arm: fix "arm: fix pci_set_consistent_dma_mask for dmabounce devices"
>
> Signed-off-by: Brian Walsh <brian@walsh.ws>
>
> diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
> index 24498a9..d54b219 100644
> --- a/arch/arm/mach-ixp4xx/common-pci.c
> +++ b/arch/arm/mach-ixp4xx/common-pci.c
> @@ -513,4 +513,5 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
> EXPORT_SYMBOL(ixp4xx_pci_read);
>  EXPORT_SYMBOL(ixp4xx_pci_write);
> +EXPORT_SYMBOL(dma_set_coherent_mask);
>

Same reply as for http://lists.arm.linux.org.uk/lurker/message/20101108.104326.f5a6c7dd.en.html :

http://lists.arm.linux.org.uk/lurker/message/20101102.114433.8822afb6.en.html


Russell, could you apply that patch?


Thanks,

Imre
