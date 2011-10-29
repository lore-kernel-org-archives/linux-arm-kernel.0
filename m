From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 29 Oct 2011 13:06:13 +0200
Subject: [PATCH] ARM: mark empty gpio.h files empty
In-Reply-To: <1319833142-4764-1-git-send-email-linus.walleij@linaro.org>
References: <1319833142-4764-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20111029110613.GE20132@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2011 at 10:19:02PM +0200, Linus Walleij wrote:
> It is generally a better idea to make intentionally empty files
> contain the human-readable /* empty */ comment, also it makes
> the files play nice with "make distclean".
> 
> Reported-by: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.

g.

> ---
>  arch/arm/mach-lpc32xx/include/mach/gpio.h |    1 +
>  arch/arm/mach-tegra/include/mach/gpio.h   |    1 +
>  arch/arm/mach-u300/include/mach/gpio.h    |    1 +
>  3 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/include/mach/gpio.h b/arch/arm/mach-lpc32xx/include/mach/gpio.h
> index e69de29..40a8c17 100644
> --- a/arch/arm/mach-lpc32xx/include/mach/gpio.h
> +++ b/arch/arm/mach-lpc32xx/include/mach/gpio.h
> @@ -0,0 +1 @@
> +/* empty */
> diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
> index e69de29..40a8c17 100644
> --- a/arch/arm/mach-tegra/include/mach/gpio.h
> +++ b/arch/arm/mach-tegra/include/mach/gpio.h
> @@ -0,0 +1 @@
> +/* empty */
> diff --git a/arch/arm/mach-u300/include/mach/gpio.h b/arch/arm/mach-u300/include/mach/gpio.h
> index e69de29..40a8c17 100644
> --- a/arch/arm/mach-u300/include/mach/gpio.h
> +++ b/arch/arm/mach-u300/include/mach/gpio.h
> @@ -0,0 +1 @@
> +/* empty */
> -- 
> 1.7.3.2
> 
