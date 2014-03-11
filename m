From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 11 Mar 2014 11:52:15 +0100
Subject: [PATCH 2/3] ARM: STi: stih416-b2020: Explicitly include STiH416
 Pinctrl bindings
In-Reply-To: <1394533324-20299-2-git-send-email-lee.jones@linaro.org>
References: <1394533324-20299-1-git-send-email-lee.jones@linaro.org>
 <1394533324-20299-2-git-send-email-lee.jones@linaro.org>
Message-ID: <531EEADF.5060001@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/11/2014 11:22 AM, Lee Jones wrote:
> At the moment we're relying on inheriting them from DTSI files which
> we're including Ideally we should be specifying these for ourselves.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/boot/dts/stih416-b2020-revE.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/stih416-b2020-revE.dts b/arch/arm/boot/dts/stih416-b2020-revE.dts
> index bcb9d00..4168b019 100644
> --- a/arch/arm/boot/dts/stih416-b2020-revE.dts
> +++ b/arch/arm/boot/dts/stih416-b2020-revE.dts
> @@ -8,6 +8,7 @@
>    */
>   /dts-v1/;
>   #include "stih416.dtsi"
> +#include "stih416-pinctrl.dtsi"
Isn't this file already included in stih416.dtsi?

>   #include "stih41x-b2020.dtsi"
>   / {
>           model = "STih416 B2020 REV. E";
>

For the next revision, could you please add kernel at stlinux.com in cc?

Regards,
Maxime
