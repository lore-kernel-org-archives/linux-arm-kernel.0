From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 29 Jun 2018 11:43:19 -0700
Subject: [PATCH V2 1/4] clk: imx6q: remove clks_init_on array
In-Reply-To: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
References: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153029779960.143105.8299429804541348750@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-06-03 18:06:43)
> Clock framework will enable those clocks registered
> with CLK_IS_CRITICAL flag, so no need to have
> clks_init_on array during clock initialization now.
> 
> ARM clock is busy divider type which has the
> CLK_IS_CRITICAL flag set by default when registered.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next
