From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 05 Feb 2013 16:40:54 +0100
Subject: [PATCH 2/2] ARM: mvebu: Update defconfig to select SPI support
In-Reply-To: <1359995888-2385-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1359995888-2385-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <51112806.4000506@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,
On 02/04/2013 05:38 PM, Ezequiel Garcia wrote:
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
> index 4e6f0ce..e243451 100644
> --- a/arch/arm/configs/mvebu_defconfig
> +++ b/arch/arm/configs/mvebu_defconfig
> @@ -40,6 +40,8 @@ CONFIG_MWIFIEX_SDIO=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_I2C=y
> +CONFIG_SPI=y
> +CONFIG_SPI_ORION=y
>  CONFIG_I2C_MV64XXX=y
>  CONFIG_SERIAL_8250_DW=y
>  CONFIG_GPIOLIB=y
> 

For this patch you can add my
Acked-by: Gregory Clement <gregory.clement@free-electrons.com>

Regards,
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
