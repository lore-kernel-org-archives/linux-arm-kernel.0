From: mturquette@ti.com (Turquette, Mike)
Date: Sun, 1 Apr 2012 22:16:49 -0700
Subject: [PATCH] clk: Remove comment for end of CONFIG_COMMON_CLK section
In-Reply-To: <1333290683-11815-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1333290683-11815-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <CAJOA=zO5z=QRf4Nr8g-DmjNOC-Dta6yJtZSjhENgz528BNCLbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 1, 2012 at 7:31 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> The comment is inaccurate (it actually ends the CONFIG_COMMON_CLK
> section, there's no else) and given that we've just got a single level
> of ifdef isn't really needed anyway.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi Mark,

I'm happy to take this into my next-clk/fixes branch (which I'll be
sending out shortly).

Regards,
Mike

> ---
> ?include/linux/clk.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index b025272..c9547d9 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -81,7 +81,7 @@ int clk_notifier_register(struct clk *clk, struct notifier_block *nb);
>
> ?int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb);
>
> -#endif /* !CONFIG_COMMON_CLK */
> +#endif
>
> ?/**
> ?* clk_get - lookup and obtain a reference to a clock producer.
> --
> 1.7.9.1
>
