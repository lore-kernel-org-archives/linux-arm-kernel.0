From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 4 Jan 2012 11:13:41 -0700
Subject: [PATCH v2 05/10] arm/dts: OMAP4: Add i2c controller nodes
In-Reply-To: <1323439361-1647-6-git-send-email-b-cousson@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-6-git-send-email-b-cousson@ti.com>
Message-ID: <20120104181341.GL15503@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 03:02:36PM +0100, Benoit Cousson wrote:
> Add i2c controllers nodes into the main ocp bus.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/arm/boot/dts/omap4.dtsi |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index bede009..9872283 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -100,5 +100,33 @@
>  			reg = <0x48241000 0x1000>,
>  			      <0x48240100 0x0100>;
>  		};
> +
> +		i2c1: i2c at 1 {
> +			compatible = "ti,omap4-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "i2c1";
> +		};
> +
> +		i2c2: i2c at 2 {
> +			compatible = "ti,omap4-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "i2c2";
> +		};
> +
> +		i2c3: i2c at 3 {
> +			compatible = "ti,omap4-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "i2c3";
> +		};
> +
> +		i2c4: i2c at 4 {
> +			compatible = "ti,omap4-i2c";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "i2c4";
> +		};
>  	};
>  };
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
