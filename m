From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 08 Jan 2015 15:39:44 -0800
Subject: [PATCH 1/2] soc: qcom: Add TCSR driver
In-Reply-To: <1420757577-20425-2-git-send-email-agross@codeaurora.org>
References: <1420757577-20425-1-git-send-email-agross@codeaurora.org>
 <1420757577-20425-2-git-send-email-agross@codeaurora.org>
Message-ID: <54AF1540.6090800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2015 02:52 PM, Andy Gross wrote:
> +
> +static struct platform_driver qcom_tcsr_driver = {
> +	.driver = {
> +		.name		= "tcsr",
> +		.owner		= THIS_MODULE,

This is done by the module_platform_driver() macro now so it's largely
unnecessary. Best to remove it so that the janitors don't find you!

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
