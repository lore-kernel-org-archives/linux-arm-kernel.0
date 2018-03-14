From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Wed, 14 Mar 2018 17:19:19 +0000
Subject: [RESEND PATCH v4 3/3] ARM: dts: STi: Remove console=ttyASN from
 bootargs for STi boards] ARM: dts: STi: Remove "console=ttyASN" from bootargs
 for STi boards
In-Reply-To: <1521039159-16655-1-git-send-email-patrice.chotard@st.com>
References: <1521039159-16655-1-git-send-email-patrice.chotard@st.com>
Message-ID: <315aff9e-506c-cbdc-874a-082c147fe81c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry

I just noticed  that the commit header is corrupted
I will resend this patch

Patrice

On 03/14/2018 03:52 PM, patrice.chotard at st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> As serial interface is already specified into stdout-path property,
> "console=ttyASN,115200" from bootargs can be removed.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
> 
> v4: _ none
> v3: _ remove "console=serialN,115200" from bootargs and use prefered
>        stdout-path property
> v2: _ none
> 
>   arch/arm/boot/dts/stih407-b2120.dts | 2 +-
>   arch/arm/boot/dts/stih410-b2120.dts | 2 +-
>   arch/arm/boot/dts/stih410-b2260.dts | 2 +-
>   arch/arm/boot/dts/stih418-b2199.dts | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
> index 37f2ddbfa099..a7a0f76e9cbc 100644
> --- a/arch/arm/boot/dts/stih407-b2120.dts
> +++ b/arch/arm/boot/dts/stih407-b2120.dts
> @@ -14,7 +14,7 @@
>   	compatible = "st,stih407-b2120", "st,stih407";
>   
>   	chosen {
> -		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> +		bootargs = "clk_ignore_unused";
>   		linux,stdout-path = &sbc_serial0;
>   	};
>   
> diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
> index a6f00a6687a9..6c6b4cc37e97 100644
> --- a/arch/arm/boot/dts/stih410-b2120.dts
> +++ b/arch/arm/boot/dts/stih410-b2120.dts
> @@ -14,7 +14,7 @@
>   	compatible = "st,stih410-b2120", "st,stih410";
>   
>   	chosen {
> -		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> +		bootargs = "clk_ignore_unused";
>   		linux,stdout-path = &sbc_serial0;
>   	};
>   
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index 62770496e328..50d36758391c 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -15,7 +15,7 @@
>   	compatible = "st,stih410-b2260", "st,stih410";
>   
>   	chosen {
> -		bootargs = "console=ttyAS1,115200 clk_ignore_unused";
> +		bootargs = "clk_ignore_unused";
>   		linux,stdout-path = &uart1;
>   	};
>   
> diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
> index 36f40f58155d..7f5f3252bfc7 100644
> --- a/arch/arm/boot/dts/stih418-b2199.dts
> +++ b/arch/arm/boot/dts/stih418-b2199.dts
> @@ -14,7 +14,7 @@
>   	compatible = "st,stih418-b2199", "st,stih418";
>   
>   	chosen {
> -		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> +		bootargs = "clk_ignore_unused";
>   		linux,stdout-path = &sbc_serial0;
>   	};
>   
> 
