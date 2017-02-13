From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 13 Feb 2017 10:35:25 -0800
Subject: [PATCH 02/10] ARM: dts: da850-evm: fix whitespace errors
In-Reply-To: <1486485683-11427-3-git-send-email-bgolaszewski@baylibre.com>
 (Bartosz Golaszewski's message of "Tue, 7 Feb 2017 17:41:15 +0100")
References: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
 <1486485683-11427-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <m2zihqdjma.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I'll fold this one into the original since it's not yet merged.

Kevin

> ---
>  arch/arm/boot/dts/da850-evm.dts | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index c970b6e..94938a3 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -301,14 +301,14 @@
>  	/* VPIF capture port */
>  	port {
>  		vpif_ch0: endpoint at 0 {
> -			  reg = <0>;
> -			  bus-width = <8>;
> +			reg = <0>;
> +			bus-width = <8>;
>  		};
>  
>  		vpif_ch1: endpoint at 1 {
> -			  reg = <1>;
> -			  bus-width = <8>;
> -			  data-shift = <8>;
> +			reg = <1>;
> +			bus-width = <8>;
> +			data-shift = <8>;
>  		};
>  	};
>  };
