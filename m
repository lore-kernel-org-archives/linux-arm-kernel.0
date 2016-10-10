From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 10 Oct 2016 02:08:05 -0700
Subject: [PATCH] arm64: defconfig: enable EEPROM_AT25 config option
In-Reply-To: <1475875432-13627-1-git-send-email-scott.branden@broadcom.com>
References: <1475875432-13627-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <a61b2b9d-356f-f24b-914b-0fb0e2bcdcc6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/07/2016 02:23 PM, Scott Branden wrote:
> Enable support for on board SPI EEPROM by turning on
> CONFIG_EEPROM_AT25.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Looks fine to me, unless this needs to be a module, Arnd, what do you think?

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index eadf485..9955ee1 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -136,6 +136,7 @@ CONFIG_MTD_SPI_NOR=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_NBD=m
>  CONFIG_VIRTIO_BLK=y
> +CONFIG_EEPROM_AT25=y
>  CONFIG_SRAM=y
>  # CONFIG_SCSI_PROC_FS is not set
>  CONFIG_BLK_DEV_SD=y
> 

-- 
Florian
