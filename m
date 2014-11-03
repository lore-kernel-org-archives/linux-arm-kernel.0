From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Nov 2014 14:26:07 +0800
Subject: [PATCH] ARM: imx: Explicitly select CONFIG_SPI
In-Reply-To: <1414617568-27615-1-git-send-email-festevam@gmail.com>
References: <1414617568-27615-1-git-send-email-festevam@gmail.com>
Message-ID: <20141103062606.GF10821@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 07:19:28PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since 3.18-rc1 CONFIG_SPI is no longer automatically selected for 
> imx_v4_v5_defconfig and imx_v6_v7_defconfig, so in order to keep the same
> behaviour as previous kernel versions and avoid regressions, let's explicitly
> select CONFIG_SPI.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Shawn,
> 
> If possible, please apply this as a bug fix for 3.18.

Can you please mention the commit that introduced the regression in the
commit log?

Shawn
