From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 6 Jan 2017 17:33:34 +0100
Subject: [RESEND PATCH] ARM: dts: stm32f469-disco: Fix memory size from
 8MB to 16MB
In-Reply-To: <20161118145845.30455-1-bmh@certi.org.br>
References: <20161118145845.30455-1-bmh@certi.org.br>
Message-ID: <a8259368-896a-64fe-4a48-71f15906dc74@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bruno,

On 11/18/2016 03:58 PM, Bruno Meirelles Herrera wrote:
> From: Bruno Herrera <bruherrera@gmail.com>
>
> This patch fix memory size to support 16MB of external SDRAM.
>
> Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
> ---
>  arch/arm/boot/dts/stm32f469-disco.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> index 75f4303..fda12a4 100644
> --- a/arch/arm/boot/dts/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> @@ -58,7 +58,7 @@
>  	};
>
>  	memory {
> -		reg = <0x00000000 0x800000>;
> +		reg = <0x00000000 0x1000000>;
>  	};
>
>  	aliases {
>
After a little cosmetic change in commit header:

Applied on stm32-dt-for-v4.11-1

Thanks!
Alex
