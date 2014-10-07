From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 07 Oct 2014 16:17:07 -0700
Subject: [PATCH v8 2/7] arm: dts: qcom: Add power-controller device node
 for 8974 Krait CPUs
In-Reply-To: <1412718106-17049-3-git-send-email-lina.iyer@linaro.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-3-git-send-email-lina.iyer@linaro.org>
Message-ID: <54347473.5010605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2014 02:41 PM, Lina Iyer wrote:
> @@ -144,7 +148,27 @@
>   			};
>   		};
>   
> -		saw_l2: regulator at f9012000 {
> +		saw0: power-controller at f9089000 {
> +			compatible = "qcom,msm8974-saw2-v2.1-cpu";
> +			reg = <0xf9089000 0x1000>;

Please add the aliases.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
