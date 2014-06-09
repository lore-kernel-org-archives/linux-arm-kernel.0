From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 9 Jun 2014 09:56:59 +0800
Subject: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
In-Reply-To: <1402051016-28853-1-git-send-email-broonie@kernel.org>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
Message-ID: <20140609015658.GV8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 11:36:56AM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Since the OPP layer is a kernel library which has been converted to be
> directly selectable by its callers rather than user selectable and
> requiring architectures to enable it explicitly the ARCH_HAS_OPP symbol
> has become redundant and can be removed. Do so.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
...
>  arch/arm/mach-imx/Kconfig      | 1 -

Acked-by: Shawn Guo <shawn.guo@freescale.com>
