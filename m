From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Dec 2011 15:37:27 +0000
Subject: [PATCH] ARM: imx_v4_v5_defconfig: Select SMSC911X driver by
 default.
In-Reply-To: <20111212141727.GX27267@pengutronix.de>
References: <1323696242-5902-1-git-send-email-fabio.estevam@freescale.com>
 <20111212141727.GX27267@pengutronix.de>
Message-ID: <201112121537.27170.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 December 2011, Sascha Hauer wrote:
> On Mon, Dec 12, 2011 at 11:24:02AM -0200, Fabio Estevam wrote:
> > Select SMSC911X driver by default.  
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> The patch is ok.
> 
> Arnd,
> 
> On which base should I apply this patch? It needs the i.MX5 -> imx
> merge which shows up in your for-next branch, but all other i.MX
> topic branches in your tree seem to be empty.
> 

Which tree are you looking at? I guess I should have announced when
the tree moved back to kernel.org, where there is only one branch
for imx right now.

Since I expect we will have to rebase the imx/move branch to get it
merged at the end of the 3.3 merge window, I can also fold the
new patch into "ARM i.MX: Update defconfig". If you prefer not
to rebase that branch, better apply it on top and send me an
updated pull request for imx/move or let me apply the patch on top.

	Arnd
