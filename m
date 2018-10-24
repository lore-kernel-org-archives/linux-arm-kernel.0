From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 24 Oct 2018 01:48:30 -0700
Subject: [PATCH v2 02/15] clk: sunxi-ng: Add check for minimal rate to NKM
 PLLs
In-Reply-To: <20181023155035.9101-3-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-3-jagan@amarulasolutions.com>
Message-ID: <154037091085.53599.3262228306180990630@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jagan Teki (2018-10-23 08:50:22)
> Some NKM PLLs doesn't work well when their output clock rate is set below
> certain rate.
> 
> So, add support for minimal rate for relevant PLLs.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
