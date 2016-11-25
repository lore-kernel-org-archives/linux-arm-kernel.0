From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 17:25:25 +0800
Subject: [PATCH 03/10] Documentation: DT: binding: axp20x_usb_power: add
 axp223 compatible
In-Reply-To: <20161125090921.23138-4-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
 <20161125090921.23138-4-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v64mB_fwKwF3YbkNunYCbx28CbQqpGw8Czu_5v-7A+a=wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 5:09 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> This adds the "x-powers,axp223-usb-power-supply" to the list of
> compatibles for AXP20X VBUS power supply driver.

Please explain why we need this. Basically the part about
AXP221 vs AXP223 from your cover letter.

ChenYu

>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> index f1d7bee..bf3953c 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> @@ -3,6 +3,7 @@ AXP20x USB power supply
>  Required Properties:
>  -compatible: One of: "x-powers,axp202-usb-power-supply"
>                       "x-powers,axp221-usb-power-supply"
> +                     "x-powers,axp223-usb-power-supply"
>
>  This node is a subnode of the axp20x PMIC.
>
> --
> 2.9.3
>
