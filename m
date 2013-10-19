From: abrestic@chromium.org (Andrew Bresticker)
Date: Fri, 18 Oct 2013 17:16:16 -0700
Subject: [PATCH v5 13/15] clk: tegra: introduce common gen4 super clock
In-Reply-To: <1382102719-5531-14-git-send-email-pdeschrijver@nvidia.com>
References: <1382102719-5531-1-git-send-email-pdeschrijver@nvidia.com>
 <1382102719-5531-14-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <CAL1qeaEpemA5ekC2qzNfQKOkjAiWU3oYp4kwmdup1s1dOjAUNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> +#define PLL_BASE_LOCK BIT(27)
> +#define PLL_MISC_LOCK_ENABLE 18

I don't see these used anywhere.

> +static const char *cclk_lp_parents[] = { "clk_m", "pll_c", "clk_32k", "pll_m",
> +                                        "pll_p", "pll_p_out4", "unused",
> +                                        "unused", "pll_x", "pll_x_out0" };

nit: insert blank line here.

> +static void __init tegra_sclk_init(void __iomem *clk_base,
> +                               struct tegra_clk *tegra_clks)
> +{

Thanks,
Andrew
