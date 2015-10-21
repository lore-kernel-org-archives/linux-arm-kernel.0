From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Tue, 20 Oct 2015 18:28:09 -0700
Subject: [PATCH 5/5] ARM: keystone: defconfig: Enable CAN support
In-Reply-To: <1445377809-12516-5-git-send-email-fcooper@ti.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
 <1445377809-12516-5-git-send-email-fcooper@ti.com>
Message-ID: <5626EA29.7050608@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2015 2:50 PM, Franklin S Cooper Jr wrote:
> Newer Keystone 2 devices support CAN. Enable CAN support as modules.
>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
Again. Please shown me the usecases before adding config
option. DTS nodes have to be there.

>   arch/arm/configs/keystone_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
> index ed3e83e..e9bd825 100644
> --- a/arch/arm/configs/keystone_defconfig
> +++ b/arch/arm/configs/keystone_defconfig
> @@ -137,6 +137,9 @@ CONFIG_I2C_DAVINCI=y
>   CONFIG_SPI=y
>   CONFIG_SPI_DAVINCI=y
>   CONFIG_SPI_SPIDEV=y
> +CONFIG_CAN=m
> +CONFIG_CAN_C_CAN=m
> +CONFIG_CAN_C_CAN_PLATFORM=m
>   CONFIG_MMC=y
>   CONFIG_MMC_OMAP_HS=y
>   # CONFIG_HWMON is not set
>
