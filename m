From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Jul 2018 14:04:41 -0700
Subject: [PATCH] clk: imx51-imx53: Annotate critical clocks as
 CLK_IS_CRITICAL
In-Reply-To: <1530712163-16130-1-git-send-email-festevam@gmail.com>
References: <1530712163-16130-1-git-send-email-festevam@gmail.com>
Message-ID: <153091108141.143105.12717931012017305757@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Fabio Estevam (2018-07-04 06:49:23)
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Instead of explicitly enabling critical clocks via clk_prepare_enable(),
> let's use the standard CLK_IS_CRITICAL flag instead, which makes the code
> a bit shorter.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---

Applied to clk-next
