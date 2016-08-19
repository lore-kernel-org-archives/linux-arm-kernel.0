From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Aug 2016 17:16:24 -0700
Subject: [PATCH v10 2/9] clk: mediatek: Refine the makefile to support
 multiple clock drivers
In-Reply-To: <1471332629-15722-3-git-send-email-erin.lo@mediatek.com>
References: <1471332629-15722-1-git-send-email-erin.lo@mediatek.com>
 <1471332629-15722-3-git-send-email-erin.lo@mediatek.com>
Message-ID: <20160819001624.GQ361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16, Erin Lo wrote:
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> new file mode 100644
> index 0000000..dc224e6
> --- /dev/null
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -0,0 +1,23 @@
> +#
> +# MediaTek SoC drivers
> +#
> +config COMMON_CLK_MEDIATEK
> +	bool
> +	---help---
> +	  Mediatek SoCs' clock support.
> +
> +config COMMON_CLK_MT8135
> +	bool "Clock driver for Mediatek MT8135"
> +	depends on COMMON_CLK

This still has depends on COMMON_CLK. Were review comments
missed?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
