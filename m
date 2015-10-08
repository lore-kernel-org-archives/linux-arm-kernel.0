From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Oct 2015 11:17:55 -0700
Subject: [PATCH 2/4] arm64: dts: qcom: Add msm8916 I2C nodes.
In-Reply-To: <1444303168-32490-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1444303124-32402-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1444303168-32490-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <5616B353.9000207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2015 04:19 AM, Srinivas Kandagatla wrote:
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 85f7bee..d49ac37 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -233,6 +233,22 @@
>  			status = "disabled";
>  		};
>  
> +		/* BLSP1 QUP2 */

This comment is useless.

> +		blsp_i2c2: i2c at 78b6000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x78b6000 0x1000>;
> +			interrupts = <GIC_SPI 96 0>;
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
