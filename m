From: timur@freescale.com (Timur Tabi)
Date: Thu, 23 Feb 2012 09:40:00 -0600
Subject: [PATCH 1/4] ASoC: imx: add an explicit Kconfig option for imx-ssi
 driver
In-Reply-To: <1330008519-3584-2-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F465DD0.1020304@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Since when do you work for Linaro?

> ---
>  sound/soc/imx/Kconfig  |    7 +++++++
>  sound/soc/imx/Makefile |    4 ++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
> index 863a6b4..b9de8a8 100644
> --- a/sound/soc/imx/Kconfig
> +++ b/sound/soc/imx/Kconfig
> @@ -8,6 +8,9 @@ menuconfig SND_IMX_SOC
>  
>  if SND_IMX_SOC
>  
> +config SND_SOC_IMX_SSI
> +	tristate
> +

I was hoping to see sound/soc/imx disappear completely, and all IMX
support move into sound/soc/fsl.  After all, i.MX is a Freescale name.

Anyway, I'm really glad to see this patchset, but I won't be able to
devote much time to studying it until next week, at the earliest.

-- 
Timur Tabi
Linux kernel developer at Freescale
