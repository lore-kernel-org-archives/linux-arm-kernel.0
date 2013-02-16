From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 10:01:55 -0500
Subject: [PATCH v2 2/4] ARM: mvebu: Update defconfig to select SPI support
In-Reply-To: <1360155984-15397-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360155984-15397-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130216150155.GQ14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 10:06:22AM -0300, Ezequiel Garcia wrote:
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Lior Amsalem <alior@marvell.com>
> Acked-by: Gregory Clement <gregory.clement@free-electrons.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Applied to mvebu/boards

thx,

Jason.

> 
> diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
> index 43a0dbf..322baca 100644
> --- a/arch/arm/configs/mvebu_defconfig
> +++ b/arch/arm/configs/mvebu_defconfig
> @@ -35,6 +35,8 @@ CONFIG_MARVELL_PHY=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_I2C=y
> +CONFIG_SPI=y
> +CONFIG_SPI_ORION=y
>  CONFIG_I2C_MV64XXX=y
>  CONFIG_SERIAL_8250_DW=y
>  CONFIG_GPIOLIB=y
> -- 
> 1.7.8.6
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
