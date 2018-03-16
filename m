From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 16 Mar 2018 15:41:22 -0700
Subject: [PATCH] clk: imx: pllv2: avoid using uninitialized values
In-Reply-To: <20180117150256.7430-1-l.stach@pengutronix.de>
References: <20180117150256.7430-1-l.stach@pengutronix.de>
Message-ID: <152124008257.242365.5597301072534827825@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lucas Stach (2018-01-17 07:02:56)
> Forward the errors returned by __clk_pllv2_set_rate() in the recalc rate
> function, to avoid using uninitialized values for the rate calculation.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---

Applied to clk-next
