From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 5 Apr 2017 11:52:35 +0800
Subject: [linux-sunxi] [PATCH 03/11] dt-bindings: add device tree binding
 for X-Powers AXP803 PMIC
In-Reply-To: <20170404180145.12897-4-icenowy@aosc.io>
References: <20170404180145.12897-1-icenowy@aosc.io>
 <20170404180145.12897-4-icenowy@aosc.io>
Message-ID: <CAGb2v66sjjn5NxZ0KJ2Q396307rURV1MAj9EfbyWah3w9RSqRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 5, 2017 at 2:01 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> AXP803 is a PMIC produced by Shenzhen X-Powers, with either I2C or RSB
> bus.
>
> Add a compatible for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index b41d2601c6ba..31607631b0d8 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -7,11 +7,12 @@ axp209 (X-Powers)
>  axp221 (X-Powers)
>  axp223 (X-Powers)
>  axp809 (X-Powers)
> +axp803 (X-Powers)
>
>  Required properties:
>  - compatible: "x-powers,axp152", "x-powers,axp202", "x-powers,axp209",
>               "x-powers,axp221", "x-powers,axp223", "x-powers,axp806",
> -             "x-powers,axp809"
> +             "x-powers,axp809", "x-powers,axp803"

Please sort them in ascending order. Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

>  - reg: The I2C slave address or RSB hardware address for the AXP chip
>  - interrupt-parent: The parent interrupt controller
>  - interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
> --
> 2.12.2
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
