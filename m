From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Feb 2015 11:31:23 -0800
Subject: [PATCH 01/12] ARM: dts: apq8064: add RPM regulators support
In-Reply-To: <1424678093-12966-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424678093-12966-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <54EF748B.3090404@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/15 23:54, Srinivas Kandagatla wrote:
> +			pm8921_s5: pm8921-s5 {
> +				compatible	= "qcom,rpm-pm8921-ftsmps";
> +				reg		= <QCOM_RPM_PM8921_SMPS5>;
> +			};
> +
> +			pm8921_s6: pm8921-s6 {
> +				compatible	= "qcom,rpm-pm8921-ftsmps";
> +				reg		= <QCOM_RPM_PM8921_SMPS6>;
> +			};
> +

There's no RPM control for S5 and S6. Please remove. Also, has this been
tested?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
