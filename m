From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 28 Sep 2014 12:13:24 +0800
Subject: [PATCH v2 2/6] clk: imx5: add step clock, used when
 reprogramming PLL1
In-Reply-To: <1411738864-26549-2-git-send-email-l.stach@pengutronix.de>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
 <1411738864-26549-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140928041322.GH12999@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 03:41:00PM +0200, Lucas Stach wrote:
> This is the bypass clock used to feed the ARM partition
> while we reprogram PLL1 to another rate.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c    | 9 ++++++++-

This is a patch touching arch/arm/ file, so should be prefixed with "ARM".
I fixed those prefix up and applied patch 2-5.

Shawn

>  include/dt-bindings/clock/imx5-clock.h | 4 +++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
