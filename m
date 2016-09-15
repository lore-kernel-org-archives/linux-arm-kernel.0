From: patrice.chotard@st.com (Patrice Chotard)
Date: Thu, 15 Sep 2016 09:44:35 +0200
Subject: [PATCH v3 03/14] ARM: DT: STiH4xx: Simplify clock binding of
 STiH4xx platforms
In-Reply-To: <1472473626-15398-4-git-send-email-gabriel.fernandez@st.com>
References: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
 <1472473626-15398-4-git-send-email-gabriel.fernandez@st.com>
Message-ID: <c2ccce91-4748-fe87-8864-b1c3a4138cb2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/29/2016 02:26 PM, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch simplifies the clock binding because we had too much detail.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  arch/arm/boot/dts/stih407-clock.dtsi | 18 +++++++++---------
>  arch/arm/boot/dts/stih410-clock.dtsi | 16 ++++++++--------
>  arch/arm/boot/dts/stih418-clock.dtsi | 16 ++++++++--------
>  3 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
> index ad45f5e..38a56d7 100644
> --- a/arch/arm/boot/dts/stih407-clock.dtsi
> +++ b/arch/arm/boot/dts/stih407-clock.dtsi
> @@ -42,7 +42,7 @@

[...]
> @@ -309,7 +309,7 @@
>  
>  		clk_s_d3_quadfs: clk-s-d3-quadfs at 9107000 {
>  			#clock-cells = <1>;
> -			compatible = "st,stih407-quadfs660-D", "st,quadfs";
> +			compatible = "st,quadfs";
>  			reg = <0x9107000 0x1000>;
>  
>  			clocks = <&clk_sysin>;
> 


Hi Gabriel

Applied on STi tree for v4.9

Thanks
