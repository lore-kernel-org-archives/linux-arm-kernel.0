From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Jul 2013 11:48:32 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: enable WEIM driver
In-Reply-To: <1373267763-28440-1-git-send-email-b32955@freescale.com>
References: <1373267763-28440-1-git-send-email-b32955@freescale.com>
Message-ID: <20130709034830.GC16656@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 03:16:03PM +0800, Huang Shijie wrote:
> enable the weim driver.
> Since the NOR is connected to the WEIM for imx6q{dl}-sabreauto,
> we also enable the MTD_PHYSMAP_OF module.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Applied, thanks.
