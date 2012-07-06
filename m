From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jul 2012 19:57:09 +0800
Subject: [PATCH] bindings: update imx and mxs #gpio-cells
In-Reply-To: <1340853337-4406-1-git-send-email-shawn.guo@linaro.org>
References: <1340853337-4406-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120706115707.GD22133@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 11:15:37AM +0800, Shawn Guo wrote:
> The of_get_named_gpio_flags can retrieve the second cell of
> gpio-specifier as the "flags".  The imx and mxs gpio driver do not
> have their own .xlate callback, which means of_gpio_simple_xlate is
> used and it's a 1:1 mapping between gpio controller flags and Linux
> "enum of_gpio_flags".
> 
> Update imx and mxs bindings document to make it clear.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Queued on imx/dt tree.

Regards,
Shawn
