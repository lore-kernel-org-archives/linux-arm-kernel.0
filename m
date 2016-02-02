From: julian.calaby@gmail.com (Julian Calaby)
Date: Wed, 3 Feb 2016 09:19:28 +1100
Subject: [linux-sunxi] [PATCH v2 4/5] ARM: dts: sun8i-h3: Add R_PIO
 controller node to the dtsi
In-Reply-To: <1454448113-18810-5-git-send-email-k@japko.eu>
References: <1454448113-18810-1-git-send-email-k@japko.eu>
 <1454448113-18810-5-git-send-email-k@japko.eu>
Message-ID: <CAGRGNgXZ2jVEFFP-Cf0ZtAa6-JbaGQwFX-+VBQe2M5f_K1mhKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Wed, Feb 3, 2016 at 8:21 AM, Krzysztof Adamski <k@japko.eu> wrote:
> Add the corresponding device node for R_PIO on H3 to the dtsi. Support
> for the controller was added in earlier commit.
>
> Signed-off-by: Krzysztof Adamski <k@japko.eu>
> ---
>  .../devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt  |  1 +
>  arch/arm/boot/dts/sun8i-h3.dtsi                              | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> index 9213b27..3e56b16 100644
> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> @@ -21,6 +21,7 @@ Required properties:
>    "allwinner,sun9i-a80-r-pinctrl"
>    "allwinner,sun8i-a83t-pinctrl"
>    "allwinner,sun8i-h3-pinctrl"
> +  "allwinner,sun8i-h3-r-pinctrl"

Shouldn't this change go in the patch that introduces the driver for
this pinctl?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
