From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 2 May 2018 14:19:25 +0200
Subject: [PATCH] ARM: dts: stm32: add reset binding on stm32mp157c
In-Reply-To: <1524215347-10600-1-git-send-email-gabriel.fernandez@st.com>
References: <1524215347-10600-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <a49de02e-5ea3-0ac7-9ae0-75add5806c6a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

On 04/20/2018 11:09 AM, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch adds reset binding file.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index bc3eddc..7e91fd6 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -5,6 +5,7 @@
>    */
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/clock/stm32mp1-clks.h>
> +#include <dt-bindings/reset/stm32mp1-resets.h>
>   
>   / {
>   	#address-cells = <1>;
> 

Applied on stm32-next.

Thanks.
Alex
