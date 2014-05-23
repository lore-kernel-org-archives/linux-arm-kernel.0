From: mporter@linaro.org (Matt Porter)
Date: Fri, 23 May 2014 08:09:16 -0400
Subject: [PATCH v2 4/4] ARM: dts: bcm590xx: add support for GPLDO and
 VBUS regulators
In-Reply-To: <1398295293-11033-5-git-send-email-mporter@linaro.org>
References: <1398295293-11033-1-git-send-email-mporter@linaro.org>
 <1398295293-11033-5-git-send-email-mporter@linaro.org>
Message-ID: <20140523120916.GY32082@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 07:21:33PM -0400, Matt Porter wrote:
> Adds additional nodes to support GPLDO1-6 and VBUS regulators which
> are now supported in the bcm590xx regulator driver.

Applied to mach-bcm for-3.16/dt

>  arch/arm/boot/dts/bcm59056.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm59056.dtsi b/arch/arm/boot/dts/bcm59056.dtsi
> index dfadaaa..066adfb 100644
> --- a/arch/arm/boot/dts/bcm59056.dtsi
> +++ b/arch/arm/boot/dts/bcm59056.dtsi
> @@ -70,5 +70,26 @@
>  
>  		vsr_reg: vsr {
>  		};
> +
> +		gpldo1_reg: gpldo1 {
> +		};
> +
> +		gpldo2_reg: gpldo2 {
> +		};
> +
> +		gpldo3_reg: gpldo3 {
> +		};
> +
> +		gpldo4_reg: gpldo4 {
> +		};
> +
> +		gpldo5_reg: gpldo5 {
> +		};
> +
> +		gpldo6_reg: gpldo6 {
> +		};
> +
> +		vbus_reg: vbus {
> +		};
>  	};
>  };
> -- 
> 1.8.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
