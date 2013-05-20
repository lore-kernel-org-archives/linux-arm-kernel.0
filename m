From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 May 2013 14:06:51 +0800
Subject: [PATCH 1/2] ARM: imx: disable pll8_mlb in mx6q_clks
In-Reply-To: <1368780045-6481-2-git-send-email-jiada_wang@mentor.com>
References: <1368780045-6481-1-git-send-email-jiada_wang@mentor.com>
 <1368780045-6481-2-git-send-email-jiada_wang@mentor.com>
Message-ID: <20130520060649.GG25113@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 05:40:44PM +0900, Jiada Wang wrote:
> The MLB PLL clock's operation doesn't fit for clock framework and
> it should be handled internally in MLB driver.
> Remove initialization of pll8_mlb clock device but leave its
> declaration in mx6q_clks to avoid affecting imx6q clock numbering.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> CC: Dirk Behme <dirk.behme@de.bosch.com>

Applied both, thanks.
