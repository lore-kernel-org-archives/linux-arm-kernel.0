From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 11 Feb 2015 17:28:14 -0800
Subject: [Patch v3 2/2] dmaengine: Add ADM driver
In-Reply-To: <1423634619-614-3-git-send-email-agross@codeaurora.org>
References: <1423634619-614-1-git-send-email-agross@codeaurora.org>
 <1423634619-614-3-git-send-email-agross@codeaurora.org>
Message-ID: <20150212012814.GI11190@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11, Andy Gross wrote:
> +static struct platform_driver adm_dma_driver = {
> +	.probe = adm_dma_probe,
> +	.remove = adm_dma_remove,
> +	.driver = {
> +		.name = "adm-dma-engine",
> +		.owner = THIS_MODULE,
> +		.of_match_table = adm_of_match,
> +	},
> +};

The THIS_MODULE script will find you. Am I a script?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
