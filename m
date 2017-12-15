From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 15 Dec 2017 12:20:06 -0800
Subject: [PATCH v4 2/2] ARM64: dts: meson-axg: add pinctrl DT info for
 Meson-AXG SoC
In-Reply-To: <20171208015418.9632-3-yixun.lan@amlogic.com> (Yixun Lan's
 message of "Fri, 8 Dec 2017 09:54:18 +0800")
References: <20171208015418.9632-1-yixun.lan@amlogic.com>
 <20171208015418.9632-3-yixun.lan@amlogic.com>
Message-ID: <7hr2rv7ngp.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> From: Xingyu Chen <xingyu.chen@amlogic.com>
>
> Add new pinctrl DT info for the Amlogic's Meson-AXG SoC.
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 44 ++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index e7213eb53958..7b24f83ab4bf 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/gpio/meson-axg-gpio.h>

FYI: I dropped this line, since it's not used (yet) and it causes an
unncessary dependency on an external tree.  It can be added back as soon
as there are users.

Kevin
