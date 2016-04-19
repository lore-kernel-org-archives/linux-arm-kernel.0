From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Apr 2016 17:58:48 +0200
Subject: [PATCH] ARM: at91/dt: fix typo in sama5d2 PIN_PD24 description
In-Reply-To: <1461081005-2513-1-git-send-email-fvallee@eukrea.fr>
References: <1461081005-2513-1-git-send-email-fvallee@eukrea.fr>
Message-ID: <20160419155848.GC29844@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please always include a commit log even if it is short.


On 19/04/2016 at 17:50:05 +0200, Florian Vallee wrote :
> Fixes: 7f16cb676c00 ("ARM: at91/dt: add sama5d2 pinmux")
> Signed-off-by: Florian Vallee <fvallee@eukrea.fr>
> ---
>  arch/arm/boot/dts/sama5d2-pinfunc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d2-pinfunc.h b/arch/arm/boot/dts/sama5d2-pinfunc.h
> index b0c912fe..8a394f3 100644
> --- a/arch/arm/boot/dts/sama5d2-pinfunc.h
> +++ b/arch/arm/boot/dts/sama5d2-pinfunc.h
> @@ -837,8 +837,8 @@
>  #define PIN_PD23__ISC_FIELD		PINMUX_PIN(PIN_PD23, 6, 4)
>  #define PIN_PD24			120
>  #define PIN_PD24__GPIO			PINMUX_PIN(PIN_PD24, 0, 0)
> -#define PIN_PD24__UTXD2			PINMUX_PIN(PIN_PD23, 1, 2)
> -#define PIN_PD24__FLEXCOM4_IO3		PINMUX_PIN(PIN_PD23, 3, 3)
> +#define PIN_PD24__UTXD2			PINMUX_PIN(PIN_PD24, 1, 2)
> +#define PIN_PD24__FLEXCOM4_IO3		PINMUX_PIN(PIN_PD24, 3, 3)
>  #define PIN_PD25			121
>  #define PIN_PD25__GPIO			PINMUX_PIN(PIN_PD25, 0, 0)
>  #define PIN_PD25__SPI1_SPCK		PINMUX_PIN(PIN_PD25, 1, 3)
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
