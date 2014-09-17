From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Wed, 17 Sep 2014 12:04:12 +0530
Subject: [PATCH] ARM: DT: ifc6410: Add board memory range.
In-Reply-To: <1410932179-4652-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1410932179-4652-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <54192B64.6070604@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srini,

Thanks for the patch.
Tested-by: Pramod Gurav <pramod.gurav@smartplayin.com>

A minor nit.
On Wednesday 17 September 2014 11:06 AM, Srinivas Kandagatla wrote:
> This patch adds memory details of IFC6410 as this is necessary to
> fix the in-correct memory start comming from ATAGs.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> index 90db8af..3287f12 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> @@ -4,6 +4,11 @@
>  	model = "Qualcomm APQ8064/IFC6410";
>  	compatible = "qcom,apq8064-ifc6410", "qcom,apq8064";
>  
> +	memory{
Space before {?
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
>  	soc {
>  		gsbi at 16600000 {
>  			status = "ok";
> 
