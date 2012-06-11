From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Jun 2012 15:04:12 +0800
Subject: [PATCH] MXS: Fix the gpmi/gpmi-nand DT name
In-Reply-To: <1339197715-19721-1-git-send-email-marex@denx.de>
References: <1339197715-19721-1-git-send-email-marex@denx.de>
Message-ID: <20120611070410.GE2552@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 09, 2012 at 01:21:55AM +0200, Marek Vasut wrote:
> Replace "gpmi" with "gpmi-nand" to get the
> GPMI interface probing with DT instead of
> failing to get clock.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied with subject changed to

	ARM: dts: imx23: Fix the gpmi/gpmi-nand DT name

Thanks,
Shawn
