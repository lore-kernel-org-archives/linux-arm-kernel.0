From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 10 Jan 2017 11:59:25 +0100
Subject: [PATCH v4 9/9] ARM: dts: stm32f4: Include auxiliary stm32fx clock
 definition
In-Reply-To: <1481638820-29324-10-git-send-email-gabriel.fernandez@st.com>
References: <1481638820-29324-1-git-send-email-gabriel.fernandez@st.com>
 <1481638820-29324-10-git-send-email-gabriel.fernandez@st.com>
Message-ID: <5a8d0752-5cf0-d709-50bc-473d02b46923@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi

On 12/13/2016 03:20 PM, Gabriel FERNANDEZ wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>
> This patch include auxiliary clock definition (clocks which are not derived
> from system clock.
>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  arch/arm/boot/dts/stm32f429.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index 7c7dfbd..041e3fc 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -48,6 +48,7 @@
>  #include "skeleton.dtsi"
>  #include "armv7-m.dtsi"
>  #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
> +#include <dt-bindings/clock/stm32fx-clock.h>
>
>  / {
>  	clocks {
>
Applied on stm32-dt-for-v4.11

Thanks
