From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 26 Oct 2010 10:53:46 +0200
Subject: [PATCH 6/7] imx/debug-macro: rework using the new io mapping macro
In-Reply-To: <1288082996-21981-6-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20101022175702.GI19834@pengutronix.de>
	<1288082996-21981-6-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20101026085346.GP8554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 10:49:55AM +0200, Uwe Kleine-K?nig wrote:
> This gets rid of the last user of IMX_NEEDS_DEPRECATED_SYMBOLS.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/plat-mxc/include/mach/debug-macro.S |   23 +++++++----------------
>  arch/arm/plat-mxc/include/mach/mx25.h        |    4 ----
>  arch/arm/plat-mxc/include/mach/mx2x.h        |    5 -----
>  arch/arm/plat-mxc/include/mach/mx3x.h        |    5 -----
>  arch/arm/plat-mxc/include/mach/mx51.h        |    5 -----
>  5 files changed, 7 insertions(+), 35 deletions(-)
Note this patch conflicts with

	0ea1293 (arm: return both physical and virtual addresses from addruart)

But it's easy to resolve.  If (and when) we agree that we want to change
the io mapping I can provide an up to date patch if need be.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
