From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 24 Oct 2018 01:48:20 -0700
Subject: [PATCH v2 01/15] clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
In-Reply-To: <20181023155035.9101-2-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-2-jagan@amarulasolutions.com>
Message-ID: <154037090051.53599.2028207035827537000@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jagan Teki (2018-10-23 08:50:21)
> DSI DPHY gate bit on MIPI DSI clock register is bit 15
> not bit 30.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
