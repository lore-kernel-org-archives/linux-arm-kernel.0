From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 27 Dec 2014 12:29:16 +0100
Subject: [PATCH 2/3] ARM: mvebu: a38x: Add the pinctrl alias
In-Reply-To: <1419678035-10658-3-git-send-email-gregory.clement@free-electrons.com>
References: <1419678035-10658-1-git-send-email-gregory.clement@free-electrons.com>
 <1419678035-10658-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20141227112916.GB21001@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 27, 2014 at 12:00:34PM +0100, Gregory CLEMENT wrote:

Hi Gregory

A one line changelog would be nice.

  Andrew

> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index ada1f206028b..f579a8929b29 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -193,7 +193,7 @@
>  				status = "disabled";
>  			};
>  
> -			pinctrl at 18000 {
> +			pinctrl: pinctrl at 18000 {
>  				compatible = "marvell,mv88f6820-pinctrl";
>  				reg = <0x18000 0x20>;
>  			};
> -- 
> 1.9.1
> 
