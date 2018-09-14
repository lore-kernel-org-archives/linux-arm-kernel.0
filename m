From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Fri, 14 Sep 2018 17:30:12 +0200
Subject: [PATCH] ARM: at91/dt: fix typo in sama5d2 pinmux descriptions
In-Reply-To: <b996f1c2271834bbf1220431ed0a08af09a6fb55.1536938317.git.mirq-linux@rere.qmqm.pl>
References: <b996f1c2271834bbf1220431ed0a08af09a6fb55.1536938317.git.mirq-linux@rere.qmqm.pl>
Message-ID: <2d8dcf62-eb7b-03de-7774-b5b4017db949@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/2018 at 17:20, Micha? Miros?aw wrote:
> Fix SSC0 pin TD0 where wrongly called TDO.
> 
> Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>

Micha?,

Thanks for your patch. But the exact same one is already integrated in 
Linus' tree as:
c8cbc1c20c29 ("ARM: dts: at91: fix typos for SSC TD functions")

Best regards,
   Nicolas

> ---
> Against v4.18.7
> 
>   arch/arm/boot/dts/sama5d2-pinfunc.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d2-pinfunc.h b/arch/arm/boot/dts/sama5d2-pinfunc.h
> index e57191fb83de..1c01a6f843d8 100644
> --- a/arch/arm/boot/dts/sama5d2-pinfunc.h
> +++ b/arch/arm/boot/dts/sama5d2-pinfunc.h
> @@ -375,7 +375,7 @@
>   #define PIN_PB22__GPIO			PINMUX_PIN(PIN_PB22, 0, 0)
>   #define PIN_PB22__LCDDAT11		PINMUX_PIN(PIN_PB22, 1, 1)
>   #define PIN_PB22__A11			PINMUX_PIN(PIN_PB22, 2, 1)
> -#define PIN_PB22__TDO			PINMUX_PIN(PIN_PB22, 3, 1)
> +#define PIN_PB22__TD0			PINMUX_PIN(PIN_PB22, 3, 1)
>   #define PIN_PB22__TIOA2			PINMUX_PIN(PIN_PB22, 4, 2)
>   #define PIN_PB22__FLEXCOM3_IO1		PINMUX_PIN(PIN_PB22, 5, 3)
>   #define PIN_PB22__GMDC			PINMUX_PIN(PIN_PB22, 6, 3)
> @@ -556,7 +556,7 @@
>   #define PIN_PC14__LCDDAT6		PINMUX_PIN(PIN_PC14, 1, 2)
>   #define PIN_PC14__GRX0			PINMUX_PIN(PIN_PC14, 2, 1)
>   #define PIN_PC14__ISC_D5		PINMUX_PIN(PIN_PC14, 3, 1)
> -#define PIN_PC14__TDO			PINMUX_PIN(PIN_PC14, 5, 2)
> +#define PIN_PC14__TD0			PINMUX_PIN(PIN_PC14, 5, 2)
>   #define PIN_PC14__A3			PINMUX_PIN(PIN_PC14, 6, 2)
>   #define PIN_PC15			79
>   #define PIN_PC15__GPIO			PINMUX_PIN(PIN_PC15, 0, 0)
> 


-- 
Nicolas Ferre
