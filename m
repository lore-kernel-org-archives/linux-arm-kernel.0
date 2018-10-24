From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 24 Oct 2018 01:49:40 -0700
Subject: [PATCH v2 12/15] clk: sunxi-ng: a64: Add min and max rate for
 PLL_MIPI
In-Reply-To: <20181023155035.9101-13-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-13-jagan@amarulasolutions.com>
Message-ID: <154037098047.53599.11415144740017316303@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jagan Teki (2018-10-23 08:50:32)
> A64 manual say PLL_MIPI rates are 500MHz to 1.4GHz, but
> using minimum 500MHz can't release the clock and which
> is not working.
> 
> So use working minimum rate as 300MHz which is tested on
> Bananapi DSI panel.

That's weird, but OK.

> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
