From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 15 Apr 2012 08:49:11 +0800
Subject: [PATCH 1/2] ARM: imx6q-arm2: Remove hardcoded mac address
In-Reply-To: <1334171256-18761-1-git-send-email-festevam@gmail.com>
References: <1334171256-18761-1-git-send-email-festevam@gmail.com>
Message-ID: <20120415004908.GB24997@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 04:07:35PM -0300, Fabio Estevam wrote:
> Do not hardcode the local mac address.
> 
> Let bootloader retrieve it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

Regards,
Shawn

> ---
>  arch/arm/boot/dts/imx6q-arm2.dts |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
> index ce1c823..04501d1 100644
> --- a/arch/arm/boot/dts/imx6q-arm2.dts
> +++ b/arch/arm/boot/dts/imx6q-arm2.dts
> @@ -29,7 +29,6 @@
>  		aips-bus at 02100000 { /* AIPS2 */
>  			enet at 02188000 {
>  				phy-mode = "rgmii";
> -				local-mac-address = [00 04 9F 01 1B 61];
>  				status = "okay";
>  			};
>  
> -- 
> 1.7.1
> 
