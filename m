From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 24 Jan 2011 17:16:09 +0800
Subject: i.MX28 fixes
In-Reply-To: <1295607474-6559-1-git-send-email-s.hauer@pengutronix.de>
References: <1295607474-6559-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110124091608.GA2625@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 11:57:51AM +0100, Sascha Hauer wrote:
> The following patches fix some issues with the i.MX28 clock support.
> 
> The following changes since commit c56eb8fb6dccb83d9fe62fd4dc00c834de9bc470:
> 
>   Linux 2.6.38-rc1 (2011-01-18 15:14:02 -0800)
> 
> are available in the git repository at:
>   none ..BRANCH.NOT.VERIFIED..
> 
> Sascha Hauer (3):
>       ARM i.MX28: fix bit operation
>       ARM i.MX28: use correct register for setting the rate
>       ARM i.MX23/28: remove secondary field from struct clk. It's unused

All acked-by: Shawn Guo <shawn.guo@freescale.com>

> 
>  arch/arm/mach-mxs/clock-mx28.c         |    4 ++--
>  arch/arm/mach-mxs/clock.c              |    2 --
>  arch/arm/mach-mxs/include/mach/clock.h |    2 --
>  3 files changed, 2 insertions(+), 6 deletions(-)
> 
> 
> 
