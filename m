From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 25 Jul 2017 10:29:48 -0700
Subject: [PATCH 3/5] arm64: dts: msm8996: Add modem smp2p nodes
In-Reply-To: <20170725054705.20674-4-bjorn.andersson@linaro.org>
References: <20170725054705.20674-1-bjorn.andersson@linaro.org>
 <20170725054705.20674-4-bjorn.andersson@linaro.org>
Message-ID: <0425e832-4784-2127-72f1-8944ee2033fa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2017 10:47 PM, Bjorn Andersson wrote:
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 8ebef05e1750..7d909546ca24 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -662,6 +662,30 @@
>  		};
>  	};
>  
> +	modem-smp2p {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <435>, <428>;
> +
> +		interrupts = <0 451 IRQ_TYPE_EDGE_RISING>;

s/0/GIC_SPI/?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
