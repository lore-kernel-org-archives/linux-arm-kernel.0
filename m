From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 14 Aug 2013 11:57:46 +0800
Subject: [PATCH 2/2] ARM: imx: Re-select CONFIG_SND_SOC_IMX_MC13783 option
In-Reply-To: <1376308553-2824-2-git-send-email-festevam@gmail.com>
References: <1376308553-2824-1-git-send-email-festevam@gmail.com>
 <1376308553-2824-2-git-send-email-festevam@gmail.com>
Message-ID: <20130814035744.GF16915@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 08:55:53AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Commit 02502da45 (ASoC: imx-mc13783: Depend on ARCH_ARM) caused the selection of
> CONFIG_SND_SOC_IMX_MC13783 to be impossible due to a wrong dependency, which
> caused CONFIG_SND_SOC_IMX_MC13783 to be removed after the defconfigs cleanups.
> 
> The original selection problem has been fixed by 9f19de649f (ASoC: imx-mc13783:
> Make SND_SOC_IMX_MC13783 visible again), so it is possible to select 
> CONFIG_SND_SOC_IMX_MC13783 again as originally done.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks
