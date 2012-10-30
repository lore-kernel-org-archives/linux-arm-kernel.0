From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 30 Oct 2012 18:50:03 +0300
Subject: [PATCH] i2c: mv64xxx: Add support Armada-XP SoC
In-Reply-To: <1351593581-19555-1-git-send-email-iwamatsu@nigauri.org>
References: <1351593581-19555-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <508FF72B.5080708@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/30/2012 01:39 PM, Nobuhiro Iwamatsu wrote:

> The Armada-XP SoC has the same I2C controller as mv64xxxi-i2c.
> This validates to use mv64xxx in this SoC.

> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  drivers/i2c/busses/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 65dd599..ff53cf4 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -474,7 +474,7 @@ config I2C_MPC
>  
>  config I2C_MV64XXX
>  	tristate "Marvell mv64xxx I2C Controller"
> -	depends on (MV64X60 || PLAT_ORION)
> +	depends on (MV64X60 || PLAT_ORION || MACH_ARMADA_370_XP)

  Could remove useless parens, while at it...

WBR, Sergei
