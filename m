From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Apr 2015 17:19:25 -0700
Subject: [PATCH] ARM: dts: qcom: Add msm8660 PMU node
In-Reply-To: <1423616763-21121-1-git-send-email-sboyd@codeaurora.org>
References: <1423616763-21121-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <5528688D.9040302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/15 17:06, Stephen Boyd wrote:
> Enable perf events on msm8660 devices by adding the pmu node.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Ping? Sorry, trying to clear out patches on a Friday night before going
home.

>  arch/arm/boot/dts/qcom-msm8660.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
> index 0affd6193f56..48330e3c8307 100644
> --- a/arch/arm/boot/dts/qcom-msm8660.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
> @@ -37,6 +37,11 @@
>  		};
>  	};
>  
> +	cpu-pmu {
> +		compatible = "qcom,scorpion-mp-pmu";
> +		interrupts = <1 9 0x304>;
> +	};
> +
>  	soc: soc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
