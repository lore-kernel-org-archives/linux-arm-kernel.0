From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Aug 2018 23:14:44 +0800
Subject: [PATCH v3 1/3] soc: imx: gpc: fix PDN delay
In-Reply-To: <1532425558626.11533@mixed-mode.de>
References: <1532425558626.11533@mixed-mode.de>
Message-ID: <20180821151441.GA32159@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 09:46:03AM +0000, Sven Schmitt wrote:
> imx6_pm_domain_power_off() reads iso and iso2sw from GPC_PGC_PUPSCR_OFFS 
> which stores the power up delays. 
> So use GPC_PGC_PDNSCR_OFFS for the correct delays.
> 
> Signed-off-by: Sven Schmitt <sven.schmitt@mixed-mode.de>

Applied, thanks.
