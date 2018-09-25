From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 25 Sep 2018 23:19:35 +0800
Subject: [PATCH 6/6] ARM: dts: vf610-zii-cfu1: Pass the 'no-sd' property
In-Reply-To: <1536696647-8228-6-git-send-email-festevam@gmail.com>
References: <1536696647-8228-1-git-send-email-festevam@gmail.com>
 <1536696647-8228-6-git-send-email-festevam@gmail.com>
Message-ID: <20180925151933.GH21282@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 05:10:47PM -0300, Fabio Estevam wrote:
> Pass the 'no-sd' for esdhc0 controller as it is wired to eMMC.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

@Andrey?

Shawn

> ---
>  arch/arm/boot/dts/vf610-zii-cfu1.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> index aba4cec..b76c3d0 100644
> --- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
> +++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> @@ -123,6 +123,7 @@
>  	no-1-8-v;
>  	keep-power-in-suspend;
>  	no-sdio;
> +	no-sd;
>  	status = "okay";
>  };
>  
> -- 
> 2.7.4
> 
