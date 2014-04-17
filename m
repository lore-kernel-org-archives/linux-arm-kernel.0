From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Apr 2014 12:56:13 +0800
Subject: [PATCH v2] ARM: dts: imx6q-gk802: Enable HDMI
In-Reply-To: <1397683430-3931-1-git-send-email-philipp.zabel@gmail.com>
References: <1397683430-3931-1-git-send-email-philipp.zabel@gmail.com>
Message-ID: <20140417045611.GR2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 11:23:50PM +0200, Philipp Zabel wrote:
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
> ---
> Changes since v1:
>  - Reordered ddc-i2c-bus and status properties
> ---
>  arch/arm/boot/dts/imx6q-gk802.dts | 5 +++++
>  1 file changed, 5 insertions(+)

Applied.  It should be sent to LAKML than LKML though.

Shawn

> 
> diff --git a/arch/arm/boot/dts/imx6q-gk802.dts b/arch/arm/boot/dts/imx6q-gk802.dts
> index 4a9b4dc..0f0c50b 100644
> --- a/arch/arm/boot/dts/imx6q-gk802.dts
> +++ b/arch/arm/boot/dts/imx6q-gk802.dts
> @@ -48,6 +48,11 @@
>  	};
>  };
>  
> +&hdmi {
> +	ddc-i2c-bus = <&i2c3>;
> +	status = "okay";
> +};
> +
>  /* Internal I2C */
>  &i2c2 {
>  	pinctrl-names = "default";
> -- 
> 1.9.1
> 
> 
> 
