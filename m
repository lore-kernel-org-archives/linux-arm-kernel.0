From: net147@gmail.com (Jonathan Liu)
Date: Fri, 21 Oct 2016 11:30:01 +1100
Subject: [linux-sunxi] [PATCH v5 3/4] Documentation: devicetree: add
 vendor prefix for Pine64
In-Reply-To: <73852fb92ac0aeec294dc9883cf235d9fa74a07b.1476986335.git-series.maxime.ripard@free-electrons.com>
References: <cover.f18c0f482ef4459b5c8f6eb5828fcb6762440974.1476986335.git-series.maxime.ripard@free-electrons.com>
 <73852fb92ac0aeec294dc9883cf235d9fa74a07b.1476986335.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CANwerB36N8q7ppKqocRs9m62h65+vrJFn37ncc-oh+Yozz_vFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 October 2016 at 05:00, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> From: Andre Przywara <andre.przywara@arm.com>
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> [Maxime: Change title prefix to match the usual style]
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index f0a48ea78659..4eefd1c3ff16 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -208,7 +208,7 @@ parade      Parade Technologies Inc.
>  pericom        Pericom Technology Inc.
>  phytec PHYTEC Messtechnik GmbH
>  picochip       Picochip Ltd
> -pixcir  PIXCIR MICROELECTRONICS Co., Ltd

Why is "pixcir  PIXCIR MICROELECTRONICS Co., Ltd" removed?

> +pine64 Pine64
>  plathome       Plat'Home Co., Ltd.
>  plda   PLDA
>  powervr        PowerVR (deprecated, use img)
> --
> git-series 0.8.10

Regards,
Jonathan
