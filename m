From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 12 Jun 2017 11:49:33 +0200
Subject: [PATCH 1/1] ARM: dts: stm32: Add missing reset-cells node in
 stm32f476
In-Reply-To: <1495034156-19593-1-git-send-email-lionel.debieve@st.com>
References: <1495034156-19593-1-git-send-email-lionel.debieve@st.com>
Message-ID: <9be06459-773b-efd0-4ee3-a191d9613ae3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lionel,

On 05/17/2017 05:15 PM, Lionel Debieve wrote:
> rcc node must include reset-cells node.
> 
> Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
> ---
>   arch/arm/boot/dts/stm32f746.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
> index c2765ce..b5a04f1 100644
> --- a/arch/arm/boot/dts/stm32f746.dtsi
> +++ b/arch/arm/boot/dts/stm32f746.dtsi
> @@ -336,6 +336,7 @@
>   		};
>   
>   		rcc: rcc at 40023800 {
> +			#reset-cells = <1>;
>   			#clock-cells = <2>;
>   			compatible = "st,stm32f746-rcc", "st,stm32-rcc";
>   			reg = <0x40023800 0x400>;
> 

Applied on stm32-dt-for-v4.13

Thanks
Alex
