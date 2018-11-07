From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Wed, 7 Nov 2018 21:58:08 +0100
Subject: [PATCH 4/9] arm64: defconfig: Drop USB_ULPI_BUS and
 USB_CHIPIDEA_ULPI
In-Reply-To: <e01448e5-9756-00a0-b51d-dbb27fe7c717@free.fr>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <e01448e5-9756-00a0-b51d-dbb27fe7c717@free.fr>
Message-ID: <f47c510c-9bf4-8b3e-3904-a4caa96b738f@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Add interested parties ]

On 07/11/2018 21:15, Marc Gonzalez wrote:

> Commit a930d8bd94d8 ("usb: chipidea: Always build ULPI code")
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  arch/arm64/configs/defconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 58741c07a6ef..6fe418d72337 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -528,7 +528,6 @@ CONFIG_USB_DWC2=y
>  CONFIG_USB_CHIPIDEA=y
>  CONFIG_USB_CHIPIDEA_UDC=y
>  CONFIG_USB_CHIPIDEA_HOST=y
> -CONFIG_USB_CHIPIDEA_ULPI=y
>  CONFIG_USB_ISP1760=y
>  CONFIG_USB_HSIC_USB3503=y
>  CONFIG_NOP_USB_XCEIV=y
> @@ -536,7 +535,6 @@ CONFIG_USB_ULPI=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_RENESAS_USBHS_UDC=m
>  CONFIG_USB_RENESAS_USB3=m
> -CONFIG_USB_ULPI_BUS=y
>  CONFIG_MMC=y
>  CONFIG_MMC_BLOCK_MINORS=32
>  CONFIG_MMC_ARMMMCI=y
> 
