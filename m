From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 29 Aug 2013 18:56:01 +0530
Subject: [PATCH v2 2/3] ARM: OMAP4+: Move SRAM data to DT
In-Reply-To: <1377775391-13103-3-git-send-email-rnayak@ti.com>
References: <1377775391-13103-1-git-send-email-rnayak@ti.com>
 <1377775391-13103-3-git-send-email-rnayak@ti.com>
Message-ID: <521F4BE9.60004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/29/2013 4:53 PM, Rajendra Nayak wrote:
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 22d9f2b..1ba6a77 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -126,6 +126,11 @@
>  			pinctrl-single,function-mask = <0x7fff>;
>  		};
>  
> +		ocmcram: ocmcram at 40304000 {

This can now be changed to 0x40300000 now that you have moved to
gen_pool_alloc()?

Thanks,
Sekhar
