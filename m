From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 24 Oct 2016 19:55:24 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Increase CMA size
In-Reply-To: <20161017163411.11888-1-marex@denx.de>
References: <20161017163411.11888-1-marex@denx.de>
Message-ID: <20161024115524.GF30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 06:34:11PM +0200, Marek Vasut wrote:
> Increase the CMA size to 64 MiB, otherwise it isn't possible to use
> etnaviv driver on systems with 1920x1080 panel due to insufficient
> memory .
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>

Applied, thanks.
