From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 10 Oct 2012 16:48:00 +0200
Subject: [PATCH 1/3] ARM: dts: Renaming elpida_ecb240abacn.dtsi as
 lpddr2_data.dtsi
In-Reply-To: <1349870716-25511-2-git-send-email-lokeshvutla@ti.com>
References: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com>
 <1349870716-25511-2-git-send-email-lokeshvutla@ti.com>
Message-ID: <50758AA0.5080307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lokesh,

On 10/10/2012 02:05 PM, Lokesh Vutla wrote:
> Renaming elpida_ecb240abacn.dtsi file generic, so that the
> same file can be reused for other parts from different vendors.

Could you elaborate a little bit?
Are these settings purely reflecting lpddr2 spec timings?

Regards,
Benoit


> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  arch/arm/boot/dts/{elpida_ecb240abacn.dtsi => lpddr2_data.dtsi} |    0
>  arch/arm/boot/dts/omap4-panda.dts                               |    2 +-
>  arch/arm/boot/dts/omap4-sdp.dts                                 |    2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename arch/arm/boot/dts/{elpida_ecb240abacn.dtsi => lpddr2_data.dtsi} (100%)
> 
> diff --git a/arch/arm/boot/dts/elpida_ecb240abacn.dtsi b/arch/arm/boot/dts/lpddr2_data.dtsi
> similarity index 100%
> rename from arch/arm/boot/dts/elpida_ecb240abacn.dtsi
> rename to arch/arm/boot/dts/lpddr2_data.dtsi
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
> index 20b966e..09d3a32 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -8,7 +8,7 @@
>  /dts-v1/;
>  
>  /include/ "omap4.dtsi"
> -/include/ "elpida_ecb240abacn.dtsi"
> +/include/ "lpddr2_data.dtsi"
>  
>  / {
>  	model = "TI OMAP4 PandaBoard";
> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
> index 94a23b3..dd749fc 100644
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -8,7 +8,7 @@
>  /dts-v1/;
>  
>  /include/ "omap4.dtsi"
> -/include/ "elpida_ecb240abacn.dtsi"
> +/include/ "lpddr2_data.dtsi"
>  
>  / {
>  	model = "TI OMAP4 SDP board";
> 
