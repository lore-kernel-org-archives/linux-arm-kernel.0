From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 21 Oct 2011 17:00:07 +0800
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <1316730422-20027-2-git-send-email-mturquette@ti.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
Message-ID: <20111021090005.GA12133@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 03:26:56PM -0700, Mike Turquette wrote:
> +/* For USE_COMMON_STRUCT_CLK, these are provided in clk.c, but not exported
> + * through other headers; we don't want them used anywhere but here. */
> +#ifdef CONFIG_USE_COMMON_STRUCT_CLK
change to CONFIG_GENERIC_CLK?
> +extern int __clk_get(struct clk *clk);
> +extern void __clk_put(struct clk *clk);
clk.c does not define it.
> +#endif

Thanks
Richard 
