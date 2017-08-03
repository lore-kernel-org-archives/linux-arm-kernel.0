From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 3 Aug 2017 10:12:09 +0800
Subject: [PATCH] ARM: dts: imx6ul-liteboard: Support poweroff
In-Reply-To: <20170801141456.10844-1-m.niestroj@grinn-global.com>
References: <20170801141456.10844-1-m.niestroj@grinn-global.com>
Message-ID: <20170803021207.GH31819@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 04:14:56PM +0200, Marcin Niestroj wrote:
> Support proper system power-off, which disables main regulator. This
> results in much lower power consumption and support of power-on issued
> by button press.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
>  arch/arm/boot/dts/imx6ul-liteboard.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-liteboard.dts b/arch/arm/boot/dts/imx6ul-liteboard.dts
> index ed1d891d6a89..c4fb5ea28e86 100644
> --- a/arch/arm/boot/dts/imx6ul-liteboard.dts
> +++ b/arch/arm/boot/dts/imx6ul-liteboard.dts
> @@ -145,3 +145,7 @@
>  	wakeup-source;
>  	status = "okay";
>  };
> +
> +&snvs_poweroff {
> +	status = "okay";
> +};

Please add the labelled node in alphabetical order.

Shawn

> -- 
> 2.13.3
> 
