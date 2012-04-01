From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 1 Apr 2012 23:25:36 +0800
Subject: [PATCH 1/2] ARM: dts: imx6q-arm2: Fix the console port
In-Reply-To: <1333293138-2610-2-git-send-email-festevam@gmail.com>
References: <1333293138-2610-1-git-send-email-festevam@gmail.com>
 <1333293138-2610-2-git-send-email-festevam@gmail.com>
Message-ID: <20120401152534.GF2395@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 01, 2012 at 12:12:18PM -0300, Fabio Estevam wrote:
> On the imx6q-arm2 board the console port is ttymxc3.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-arm2.dts |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
> index ce1c823..8b90ea1 100644
> --- a/arch/arm/boot/dts/imx6q-arm2.dts
> +++ b/arch/arm/boot/dts/imx6q-arm2.dts
> @@ -18,7 +18,7 @@
>  	compatible = "fsl,imx6q-arm2", "fsl,imx6q";
>  
>  	chosen {
> -		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk3p3 rootwait";
> +		bootargs = "console=ttymxc3,115200 root=/dev/mmcblk3p3 rootwait";

Rather than patching the line, I would suggest remove it completely.
I do not see a use case for this.

>  	};
>  
>  	memory {
> -- 
> 1.7.1
> 

-- 
Regards,
Shawn
