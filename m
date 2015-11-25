From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 25 Nov 2015 11:49:57 +0800
Subject: [PATCH v2 resend] clk: imx25: Remove osc clock from driver
In-Reply-To: <1448363878-14551-1-git-send-email-mpa@pengutronix.de>
References: <1448363878-14551-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20151125034957.GE11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 12:17:58PM +0100, Markus Pargmann wrote:
> The 'osc' clock is already initialized by the fixed clock defined in
> imx25.dtsi. The imx25 clock driver tries to add this clock for a second
> time and fails with -EEXIST:
> 	i.MX clk 1: register failed with -17
> 
> As the clock is already properly setup in DT with a different driver, we
> can completely remove the handling in the imx25 clock driver.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
