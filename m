From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Dec 2016 00:12:57 +0800
Subject: [PATCH v2 04/11] Documentation: DT: binding: axp20x_usb_power:
 add axp223 compatible
In-Reply-To: <20161209110419.28981-5-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
 <20161209110419.28981-5-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v667MzjsnPhZBz3avi_oUho7WH=e6-Ez0J4Qhg1_Q0K0aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2016 at 7:04 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> This adds the "x-powers,axp223-usb-power-supply" to the list of
> compatibles for AXP20X VBUS power supply driver.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>
> v2:
>  - adding small explanation on AXP223 variation compared to the AXP221,
>
>  Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> index f1d7bee..ba8d35f 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
> @@ -3,6 +3,11 @@ AXP20x USB power supply
>  Required Properties:
>  -compatible: One of: "x-powers,axp202-usb-power-supply"
>                       "x-powers,axp221-usb-power-supply"
> +                     "x-powers,axp223-usb-power-supply"
> +
> +The AXP223 PMIC shares most of its behaviour with the AXP221 but has slight
> +variations such as the former being able to set the VBUS power supply max
> +current to 100mA, unlike the latter.

I actually wanted this in the commit log, but this works too.

Acked-by: Chen-Yu Tsai <wens@csie.org>

>
>  This node is a subnode of the axp20x PMIC.
>
> --
> 2.9.3
>
