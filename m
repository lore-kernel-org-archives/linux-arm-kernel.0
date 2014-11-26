From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Nov 2014 14:48:27 -0800
Subject: [PATCH 07/10] qcom: cpuidle: Add cpuidle driver for QCOM cpus
In-Reply-To: <1417040910-43290-8-git-send-email-lina.iyer@linaro.org>
References: <1417040910-43290-1-git-send-email-lina.iyer@linaro.org>
 <1417040910-43290-8-git-send-email-lina.iyer@linaro.org>
Message-ID: <547658BB.9040300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2014 02:28 PM, Lina Iyer wrote:
> +
> +static struct platform_driver qcom_cpuidle_plat_driver = {
> +	.probe	= qcom_cpuidle_probe,
> +	.driver = {
> +		.name = "qcom_cpuidle",
> +	},
> +};
> +
> +module_platform_driver(qcom_cpuidle_plat_driver);

Said this a few reviews ago...

MODULE_LICENSE()?
MODULE_ALIAS()?
MODULE_DESCRIPTION()?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
