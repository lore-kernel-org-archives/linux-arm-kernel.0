From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 24 Oct 2014 23:20:38 +0200
Subject: [PATCHv0 1/2] arm: mvebu: fix LED color in NETGEAR ReadyNAS 102
 .dts file
In-Reply-To: <4eb4049d934a3a8fe9f7235dafb6842422792566.1414185031.git.arno@natisbad.org>
References: <cover.1414185031.git.arno@natisbad.org>
 <4eb4049d934a3a8fe9f7235dafb6842422792566.1414185031.git.arno@natisbad.org>
Message-ID: <20141024212038.GB6436@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 11:22:01PM +0200, Arnaud Ebalard wrote:
> 
> When writing initial .dts file for NETGEAR ReadyNAS 102, I put the wrong color
> for backup and SATA leds (green instead of blue for all three).
> 
> Reported-by: Johan Kristell <johan.kristell@gmail.com>
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew

> ---
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> index 3aebd93cc33c..f79579bdf8fe 100644
> --- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> @@ -204,20 +204,20 @@
>  			default-state = "keep";
>  		};
>  
> -		green-sata1-led {
> -			label = "rn102:green:sata1";
> +		blue-sata1-led {
> +			label = "rn102:blue:sata1";
>  			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
>  			default-state = "on";
>  		};
>  
> -		green-sata2-led {
> -			label = "rn102:green:sata2";
> +		blue-sata2-led {
> +			label = "rn102:blue:sata2";
>  			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
>  			default-state = "on";
>  		};
>  
> -		green-backup-led {
> -			label = "rn102:green:backup";
> +		blue-backup-led {
> +			label = "rn102:blue:backup";
>  			gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
>  			default-state = "on";
>  		};
> -- 
> 2.1.1
> 
> 
