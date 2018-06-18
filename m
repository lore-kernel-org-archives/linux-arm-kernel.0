From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 18 Jun 2018 09:06:53 +0200
Subject: [PATCH] dt-bindings: Fix unbalanced quotation marks
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Message-ID: <CAJKOXPcAVovxU2mHSbkAG0axutFbd=_92bNdd2P_CnQGmhAfCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2018 at 4:31 PM, Jonathan Neusch?fer
<j.neuschaefer@gmx.net> wrote:
> Multiple binding documents have various forms of unbalanced quotation
> marks. Fix them.
>
> Signed-off-by: Jonathan Neusch?fer <j.neuschaefer@gmx.net>
> ---
>
> Should I split this patch so that different parts can go through different trees?
> ---
>  .../devicetree/bindings/arm/samsung/samsung-boards.txt          | 2 +-
>  .../devicetree/bindings/gpio/nintendo,hollywood-gpio.txt        | 2 +-
>  Documentation/devicetree/bindings/input/touchscreen/hideep.txt  | 2 +-
>  .../bindings/interrupt-controller/nvidia,tegra20-ictlr.txt      | 2 +-
>  .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt  | 2 +-
>  Documentation/devicetree/bindings/mips/brcm/soc.txt             | 2 +-
>  Documentation/devicetree/bindings/net/fsl-fman.txt              | 2 +-
>  Documentation/devicetree/bindings/power/power_domain.txt        | 2 +-
>  Documentation/devicetree/bindings/regulator/tps65090.txt        | 2 +-
>  Documentation/devicetree/bindings/reset/st,sti-softreset.txt    | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt    | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,apq8096.txt        | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> index bdadc3da9556..6970f30a3770 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> @@ -66,7 +66,7 @@ Required root node properties:
>         - "insignal,arndale-octa" - for Exynos5420-based Insignal Arndale
>                                     Octa board.
>         - "insignal,origen"       - for Exynos4210-based Insignal Origen board.
> -       - "insignal,origen4412    - for Exynos4412-based Insignal Origen board.
> +       - "insignal,origen4412"   - for Exynos4412-based Insignal Origen board.
>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
