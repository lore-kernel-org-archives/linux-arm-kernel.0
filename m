From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 29 Jun 2018 11:43:26 -0700
Subject: [PATCH V2 3/4] clk: imx6sx: remove clks_init_on array
In-Reply-To: <1528074406-11735-3-git-send-email-Anson.Huang@nxp.com>
References: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
 <1528074406-11735-3-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153029780620.143105.12394629192902595958@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-06-03 18:06:45)
> Clock framework will enable those clocks registered
> with CLK_IS_CRITICAL flag, so no need to have
> clks_init_on array during clock initialization now.
> 
> ARM clock is busy divider type which has the
> CLK_IS_CRITICAL flag set by default when registered.
> 
> IPG clock has no clock gate and its parent AHB clock
> is busy divider type, so no need to add CLK_IS_CRITICAL
> flag for IPG clock.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next
