From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 3 Jan 2017 10:04:39 +0100
Subject: [PATCH v2 1/2] mtd: ifc: Update dependency of IFC for LS1021A
In-Reply-To: <1483411266-45875-1-git-send-email-b18965@freescale.com>
References: <1483411266-45875-1-git-send-email-b18965@freescale.com>
Message-ID: <20170103100439.6e7360c6@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alison,

The subject prefix should be "memory: " and not "mtd: ifc: ".

Looks good otherwise.

No need to resend, I can fix that when applying.

Regards,

Boris

On Tue, 3 Jan 2017 10:41:05 +0800
Alison Wang <b18965@freescale.com> wrote:

> As Freescale/NXP IFC controller is available on LS1021A, the dependency
> for LS1021A is added.
> 
> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> ---
> Changes in v2:
> - New patch
> 
>  drivers/memory/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index ec80e35..fff8345 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -115,7 +115,7 @@ config FSL_CORENET_CF
>  
>  config FSL_IFC
>  	bool
> -	depends on FSL_SOC || ARCH_LAYERSCAPE
> +	depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A
>  
>  config JZ4780_NEMC
>  	bool "Ingenic JZ4780 SoC NEMC driver"
