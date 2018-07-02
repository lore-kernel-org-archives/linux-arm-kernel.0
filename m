From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Jul 2018 17:32:11 +0530
Subject: [PATCH v7 4/4] ARM: davinci: dts: add a reset control to the dsp
 node
In-Reply-To: <20180621073706.22812-5-brgl@bgdev.pl>
References: <20180621073706.22812-1-brgl@bgdev.pl>
 <20180621073706.22812-5-brgl@bgdev.pl>
Message-ID: <b3fafb57-86e0-3124-1322-9020b793ccf7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 June 2018 01:07 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The davinci-rproc driver will soon use the reset framework. Add the
> resets property to the dsp node in da850.dtsi.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 1bc0e4bc0697..225e0cf4b7bc 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -118,6 +118,7 @@
>  		interrupt-parent = <&intc>;
>  		interrupts = <28>;
>  		clocks = <&psc0 15>;
> +		resets = <&psc0 15>;

Applied to v4.19/dt

Thanks,
Sekhar
