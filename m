From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Nov 2014 12:05:08 -0800
Subject: [PATCH v10 05/10] arm: dts: qcom: Add power-controller device
 node for 8084 Krait CPUs
In-Reply-To: <1416593037-27527-6-git-send-email-lina.iyer@linaro.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
 <1416593037-27527-6-git-send-email-lina.iyer@linaro.org>
Message-ID: <54763274.6010006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2014 10:03 AM, Lina Iyer wrote:
> @@ -144,7 +148,27 @@
>   			};
>   		};
>   
> -		saw_l2: regulator at f9012000 {
> +		saw0: power-controller at f9089000 {
> +			compatible = "qcom,apq8084-saw2-v2.1-cpu";
> +			reg = <0xf9089000 0x1000>;
> +		};
> +
> +		saw1: power-controller at f9099000 {
> +			compatible = "qcom,apq8084-saw2-v2.1-cpu";
> +			reg = <0xf9099000 0x1000>;
> +		};
> +
> +		saw2: power-controller at f90a9000 {
> +			compatible = "qcom,apq8084-saw2-v2.1-cpu";
> +			reg = <0xf90a9000 0x1000>;
> +		};
> +
> +		saw3: power-controller at f90b9000 {
> +			compatible = "qcom,apq8084-saw2-v2.1-cpu";
> +			reg = <0xf90b9000 0x1000>;
> +		};
>

Same comment as in patch 4, please add the second reg property.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
