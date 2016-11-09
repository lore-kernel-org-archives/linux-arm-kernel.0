From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2016 15:48:59 -0700
Subject: [PATCH] ARM: dts: am335x-baltos: don't reset gpio3 block
In-Reply-To: <1478077696-21003-1-git-send-email-yegorslists@googlemail.com>
References: <1478077696-21003-1-git-send-email-yegorslists@googlemail.com>
Message-ID: <20161109224858.GO2428@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* yegorslists at googlemail.com <yegorslists@googlemail.com> [161102 02:08]:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> This change is needed in order to enable some hardware components
> from bootloader.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  arch/arm/boot/dts/am335x-baltos.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
> index dd45d17..09b9541 100644
> --- a/arch/arm/boot/dts/am335x-baltos.dtsi
> +++ b/arch/arm/boot/dts/am335x-baltos.dtsi
> @@ -406,3 +406,7 @@
>  &gpio0 {
>  	ti,no-reset-on-init;
>  };
> +
> +&gpio3 {
> +	ti,no-reset-on-init;
> +};

Applying into omap-for-v4.10/dt thanks.

Tony
