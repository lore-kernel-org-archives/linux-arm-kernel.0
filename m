From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 May 2015 15:04:10 -0700
Subject: [PATCHv3 01/27] ARM: OMAP2+: clock: export driver API to
 setup/get clock features
In-Reply-To: <1432566032-10860-2-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
 <1432566032-10860-2-git-send-email-t-kristo@ti.com>
Message-ID: <20150528220410.GG24204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25, Tero Kristo wrote:
> +
> +/**
> + * ti_clk_get_features - get clock driver features flags
> + *
> + * Get TI clock driver features description. Returns a pointer
> + * to the current feature setup.
> + */
> +struct ti_clk_features *ti_clk_get_features(void)

const?

> +{
> +	return &ti_clk_features;
> +}
>  #endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
