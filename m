From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 May 2015 18:19:01 -0700
Subject: [PATCHv2 01/27] ARM: OMAP2+: clock: export driver API to
 setup/get clock features
In-Reply-To: <1431334493-24455-2-git-send-email-t-kristo@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
 <1431334493-24455-2-git-send-email-t-kristo@ti.com>
Message-ID: <20150520011901.GB31054@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11, Tero Kristo wrote:
> +
> +/**
> + * ti_clk_get_features - get clock driver features flags
> + *
> + * Get TI clock driver features description. Returns a pointer
> + * to the current feature setup.
> + */
> +struct ti_clk_features *ti_clk_get_features(void)

Should this return a const pointer?

> +{
> +	return &ti_clk_features;
> +}
>  #endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
