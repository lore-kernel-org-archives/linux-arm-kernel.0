From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 11 Jun 2018 13:26:09 +0800
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: add rave-sp subdevices
In-Reply-To: <20180517191923.16212-1-nikita.yoush@cogentembedded.com>
References: <20180517191923.16212-1-nikita.yoush@cogentembedded.com>
Message-ID: <20180611052608.GB16091@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 10:19:23PM +0300, Nikita Yushchenko wrote:
> This adds rave-sp powerbutton and backlight devices to RDU1 device tree.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  arch/arm/boot/dts/imx51-zii-rdu1.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index 0c99ac04ad08..98cc107098e0 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -581,6 +581,14 @@
>  		watchdog {
>  			compatible = "zii,rave-sp-watchdog";
>  		};
> +
> +		backlight {
> +			compatible = "zii,rave-sp-backlight";
> +		};
> +
> +		pwrbutton {
> +			compatible = "zii,rave-sp-pwrbutton";
> +		};

Where are these compatibles documented?

Shawn

>  	};
>  };
>  
> -- 
> 2.11.0
> 
