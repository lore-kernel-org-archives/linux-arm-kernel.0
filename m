From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Fri, 20 Apr 2018 09:40:30 +0000
Subject: [PATCH] ARM: dts: stm32: add reset binding on stm32mp157c
In-Reply-To: <1524215347-10600-1-git-send-email-gabriel.fernandez@st.com>
References: <1524215347-10600-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <26cab19f-e8ea-edf1-9ee7-e7a0cc589d2d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


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

Reviewed-by: Amelie Delaunay <amelie.delaunay@st.com>
