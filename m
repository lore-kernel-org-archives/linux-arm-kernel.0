From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Apr 2014 22:49:32 +0200
Subject: [PATCH 2/8] ARM: at91: sama5d3: disable sound by default
In-Reply-To: <1395049541-28128-3-git-send-email-voice.shen@atmel.com>
References: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
 <1395049541-28128-3-git-send-email-voice.shen@atmel.com>
Message-ID: <53518FDC.2020004@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/2014 10:45, Bo Shen :
> Make the sound device in disabled status by default
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
> 
>  arch/arm/boot/dts/sama5d3xmb.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
> index dba739b..2938605 100644
> --- a/arch/arm/boot/dts/sama5d3xmb.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
> @@ -170,5 +170,7 @@
>  
>  		atmel,ssc-controller = <&ssc0>;
>  		atmel,audio-codec = <&wm8904>;
> +
> +		status = "disabled";
>  	};
>  };
> 


-- 
Nicolas Ferre
