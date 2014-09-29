From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 29 Sep 2014 16:02:03 -0700
Subject: [PATCH v7 2/7] arm: dts: qcom: Add SPM device bindings for 8974
In-Reply-To: <1411779495-39724-3-git-send-email-lina.iyer@linaro.org>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-3-git-send-email-lina.iyer@linaro.org>
Message-ID: <5429E4EB.2050708@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/14 17:58, Lina Iyer wrote:
> @@ -144,7 +148,27 @@
>  			};
>  		};
>  
> -		saw_l2: regulator at f9012000 {
> +		saw0: saw at f9089000 {
> +			compatible = "qcom,msm8974-saw2-v2.1-cpu";
> +			reg = <0xf9089000 0x1000>;

There is another reg property as part of the binding that should be
specified here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
